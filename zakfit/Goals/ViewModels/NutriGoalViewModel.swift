//
//  NutriGoalViewModel.swift
//  zakfit
//
//  Created by alize suchon on 03/12/2025.
//

import SwiftUI

struct NutritionGoalDTO: Codable {
    let caloriesTarget: Double
    let proteinsTarget: Double?
    let carbsTarget: Double?
    let fatsTarget: Double?
    let isAuto: Bool
}

@Observable
final class NutriGoalViewModel {
    
    var nutriGoal: NutritionGoalDTO?
//    var appState: AppState
//    
//    init(appState: AppState) {
//        self.appState = appState
//    }
    init() {}
    
    //CREATE NUTRI GOAL PERSO
    func fetchNutriGoal(token: String, caloriesTarget: Double, proteinsTarget: Double?, carbsTarget: Double?, fatsTarget: Double?, isAuto: Bool) async {
        guard let url = URL(string: "http://127.0.0.1:8080/nutritionGoal/current") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let newGoal = NutritionGoalDTO(
            caloriesTarget: caloriesTarget,
            proteinsTarget: proteinsTarget,
            carbsTarget: carbsTarget,
            fatsTarget: fatsTarget,
            isAuto: isAuto
        )
        
        do {
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode(newGoal)
            let (_, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) {
                print("success : User Goal is created")
            }
        } catch {
            print("Error: create user goal : \(error)")
        }
    }
    
    //CREATE GOAL CALCUL AUTO
    func fetchAutoNutriGoal(token: String) async {
        guard let user = AppState().user else {
            print("Error: No user info available")
            return
        }
        
        // BMR
        guard
            let weight = user.weight,
            let size = user.size,
            let age = user.age,
            let gender = user.gender,
            let objective = user.objective
        else {
            print("Error: missing user data")
            return
        }
        
        let BMR: Double
        if gender == "homme" {
            BMR = 10 * Double(weight) + 6.25 * Double(size) - 5 * Double(age) + 5
        } else {
            BMR = 10 * Double(weight) + 6.25 * Double(size) - 5 * Double(age) - 161
        }
        
        //CALCUL VIA OBJECTIF VISÉ
        var calories: Double
        var proteinFactor: Double
        var fatPercentage: Double
        
        switch objective {
        case "Perdre du poids":
            calories = BMR * 1.4 - 200
            proteinFactor = 1.8
            fatPercentage = 0.25
        case "Prendre du muscle":
            calories = BMR * 1.6 + 200
            proteinFactor = 1.8
            fatPercentage = 0.25
        case "Maintenir mon poids":
            calories = BMR * 1.5
            proteinFactor = 1.6
            fatPercentage = 0.30
        default:
            calories = BMR * 1.5
            proteinFactor = 1.6
            fatPercentage = 0.30
        }
        
        // Macros
        let proteins = proteinFactor * Double(weight)
        let fats = (calories * fatPercentage) / 9
        let carbs = (calories - (proteins * 4) - (fats * 9)) / 4
        
        let dto = NutritionGoalDTO(
            caloriesTarget: calories,
            proteinsTarget: proteins,
            carbsTarget: carbs,
            fatsTarget: fats,
            isAuto: true
        )
        
        guard let url = URL(string: "http://127.0.0.1:8080/nutritionGoal/current") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode(dto)
            
            let (_, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse,
               (200...299).contains(httpResponse.statusCode) {
                print("Success: auto goal created")
            } else {
                print("Error: \(response)")
            }
            
        } catch {
            print("Error: \(error)")
        }
    }
    
    //GET USER NUTRI GOAL
    func getNutriGoal(token: String) async {
           guard let url = URL(string: "http://127.0.0.1:8080/nutritionGoal/current") else { return }
           
           var request = URLRequest(url: url)
           request.httpMethod = "GET"
           request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
           
           do {
               let (data, response) = try await URLSession.shared.data(for: request)
               
               if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) {
                   let decoder = JSONDecoder()
                   let goal = try decoder.decode(NutritionGoalDTO.self, from: data)
                   nutriGoal = goal
                   
                   print("Succes : Goal fetched")
                   
               } else {
                   print("Error fetching goal: \(response)")
               }
           } catch {
               print("Error: \(error)")
           }
       }
}

