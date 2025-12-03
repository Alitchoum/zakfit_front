//
//  MealViewModel.swift
//  zakfit
//
//  Created by alize suchon on 30/11/2025.
//

import SwiftUI

struct MealResponseDTO: Codable, Identifiable {
    var id: UUID
    var type: String
    var totalCalories: Double
    var totalCarbs: Double
    var totalProteins: Double
    var totalFats: Double
    var date: Date
    var userId: UUID
    var foods: [FoodInMealResponse]?
}

struct FoodInMealResponse: Identifiable, Codable {
    let id: UUID
    let name: String
    let quantity: Int
    let calories: Double
    let carbs: Double
    let proteins: Double
    let fats: Double
}


struct FoodCategoriesResponse: Identifiable, Codable {
    let id: UUID
    let name: String
    let picto: String
}

struct CreateMealDTO: Codable {
    let type: String
    let date: Date
}

struct CreateUserFoodDTO: Codable {
    let name: String
    let calories100g: Double
    let carbs100g: Double
    let fats100g: Double
    let proteins100g: Double
    let isCustom: Bool
    let foodCategoryID: UUID
}

struct FoodResponse: Codable, Identifiable {
    let id: UUID
    let name: String
    let calories100g: Double
    let carbs100g: Double
    let fats100g: Double
    let proteins100g: Double
    let isCustom: Bool
    let foodCategoryID: UUID
}

struct AddFoodToMealDTO: Codable {
    let foodID: UUID
    let quantity: Int
}

@Observable
final class MealViewModel {
    
    var foodCategories : [FoodCategoriesResponse] = []
    var foods: [FoodResponse] = []
    var meals: [MealResponseDTO] = []
    
    var foodsInMeal: [FoodInMealResponse] = []
    var currentMeal: MealResponseDTO?
    
    var isLoading = false
    var errorMessage: String?
    var searchText = ""
    var selectedCategoryID: UUID?
    
    
//    var totalCalories: Int {
//        foodsInMeal.reduce(0) { $0 + Int($1.calories) }
//    }
//
//    var totalCarbs: Int {
//        foodsInMeal.reduce(0) { $0 + Int($1.carbs) }
//    }
//
//    var totalProteins: Int {
//        foodsInMeal.reduce(0) { $0 + Int($1.proteins) }
//    }
//
//    var totalFats: Int {
//        foodsInMeal.reduce(0) { $0 + Int($1.fats) }
//    }
    
    //LOAD CATEGORIES FOOD
    func fetchFoodCategories() async {
        guard let url = URL(string: "http://127.0.0.1:8080/foodCategories") else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let decodedFoodCategories = try decoder.decode([FoodCategoriesResponse].self, from: data)
            foodCategories = decodedFoodCategories
            
        } catch {
            print("Error: fetching data (categories food): \(error)")
        }
    }
    
    //SEND CREATE USER FOOD
    func sendUserFood(token: String, name: String, calories100g: Double, carbs100g: Double, fats100g: Double, proteins100g: Double, foodCategoryID: UUID) async {
        
        guard let url = URL(string: "http://127.0.0.1:8080/foods/current") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let newUserFood = CreateUserFoodDTO(
            name: name,
            calories100g: calories100g,
            carbs100g: carbs100g,
            fats100g: fats100g,
            proteins100g: proteins100g,
            isCustom: true,
            foodCategoryID: foodCategoryID
        )
        
        do {
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode(newUserFood)
            let (_, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) {
                print("success : User Food is created")
            }
        } catch {
            print("Error send user food : \(error)")
        }
    }
    
    //LOAD ALL FOODS USER + ADMIN
    func fetchAllFoods(token: String) async {
        
        guard let url = URL(string: "http://127.0.0.1:8080/foods/current") else { return }
        
        do {
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
            let (data, _) = try! await URLSession.shared.data(for: request)
            
            let decoder = JSONDecoder()
            let decodedFoods = try decoder.decode([FoodResponse].self, from: data)
            foods = decodedFoods
        } catch {
            print("Error: decoding data (foods response): \(error)")
        }
    }
    
    //SEND CREATE MEAL
    func sendCreateMeal(token: String, type: String) async -> MealResponseDTO? {
        guard let url = URL(string: "http://127.0.0.1:8080/meals/current") else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let newMeal = CreateMealDTO(type: type, date: Date())
        
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            request.httpBody = try encoder.encode(newMeal)
            
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Error status code: \((response as? HTTPURLResponse)?.statusCode ?? 0)")
                return nil
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let createdMeal = try decoder.decode(MealResponseDTO.self, from: data)
            
            print("Meal created with foods:")
            return createdMeal
        } catch {
            print("Error creating meal:", error)
            return nil
        }
    }

    //(CREATE) -> ADD FOODS TO USER MEAL (TABLE PIVOT FOOD MEALS)
    func addFoodToMeal(token: String, mealID: UUID, foodID: UUID, quantity: Int) async {
        
        guard let url = URL(string: "http://127.0.0.1:8080/meals/\(mealID)/foods") else { return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = AddFoodToMealDTO(foodID: foodID, quantity: quantity)
        let encoder = JSONEncoder()
        
        do {
            request.httpBody = try encoder.encode(body)
            let (_, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error code:", (response as? HTTPURLResponse)?.statusCode ?? 0)
                return
            }
            print("Food added to meal successfully.")
            
        } catch {
            print("Error: add food to meal : \(error)")
        }
    }
    
    //FETCH DETAIL OF MEAL WITH HIS FOODS
    func fetchMealDetails(token: String, mealID: UUID) async {
        guard let url = URL(string: "http://127.0.0.1:8080/meals/\(mealID)") else {
            await MainActor.run { self.errorMessage = "URL invalide" }
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw URLError(.badServerResponse)
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let meal = try decoder.decode(MealResponseDTO.self, from: data)
            
            await MainActor.run {
                self.currentMeal = meal
                self.foodsInMeal = meal.foods ?? [] // ✅ tableau vide si pas d’aliments
            }
            
            print("Fetched meal foods:")
            
        } catch {
            await MainActor.run {
                self.errorMessage = "Error load meal: \(error.localizedDescription)"
            }
        }
    }

    //REFRESH MEAL AFTER ADD FOOD
    func refreshMeal(token: String, mealID: UUID) async {
        await fetchMealDetails(token: token, mealID: mealID)
    }
   
}

