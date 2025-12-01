//
//  MealViewModel.swift
//  zakfit
//
//  Created by alize suchon on 30/11/2025.
//

import SwiftUI

struct Meal: Codable {
    var type: String
    var image: String?
    var picto : String
    var totalCalories : Double
    var totalCarbs : Double
    var totalProteins : Double
    var totalFats : Double
    var date : Date
}

struct FoodCategoriesResponse: Identifiable, Codable {
    let id: UUID
    let name: String
    let picto: String
}

struct CreateMealDTO: Codable {
        let type: String
        let image: String?
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

@Observable
final class MealViewModel {
    
    var foodCategories : [FoodCategoriesResponse] = []
    var foods: [FoodResponse] = []
    //var meals: [] = []
    //var foodMeals: [] = []
    
    //var searchText = ""
    
    
    //FETCH CATEGORIES FOOD
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
    
    //FETCH ALL FOODS USER + ADMIN
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
    func sendCreateMeal(token: String, type: String, image: String?, date: Date) async {
        guard let url = URL(string: "http://127.0.0.1:8080/meals/current") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let newMeal = CreateMealDTO(
            type : type,
            image: image,
            date: Date()
        )
        
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            request.httpBody = try? encoder.encode(newMeal)
            let (_, Response) = try await URLSession.shared.data(for: request)
            if let httpResponse = Response as? HTTPURLResponse {
                if (200...299).contains(httpResponse.statusCode) {
                    print("Success: Meal is created.")
                } else {
                    print("Error status code: \(httpResponse.statusCode)")
                }
            }
        } catch {
            print("Error: decoding data (Meals response): \(error)")
        }
    }
    
    //AJOUTER LE GET POUR AFFICHER LES FOODS + LOGIQUE SEARCH
}
