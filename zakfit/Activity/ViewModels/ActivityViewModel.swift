//
//  ActivityViewModel.swift
//  zakfit
//
//  Created by alize suchon on 30/11/2025.
//

import SwiftUI

@Observable
final class ActivityViewModel {
    
    var categories: [CategoryResponse] = []
    var activities: [ActivityResponse] = []
    
    //FETCH CATEGORIES ACTIVITY
    func fetchCategories() async {
        guard let url = URL(string: "http://127.0.0.1:8080/categoryactivities") else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let decodedCategories = try decoder.decode([CategoryResponse].self, from: data)
            categories = decodedCategories
        } catch {
            print("Error: fetching or decoding data (categories): \(error)")
        }
    }
    
    //SEND ACTIVITY DTO (USER)
    func sendActivityDTO(token: String, duration: Int, caloriesBurned: Int, categoryID: UUID) async {
        guard let url = URL(string: "http://127.0.0.1:8080/activities/current") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let newActivity = ActivityDTO(
            duration: duration,
            caloriesBurned: caloriesBurned,
            date: Date(),
            categoryId: categoryID
        )
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        request.httpBody = try? encoder.encode(newActivity)
        
        do {
            let (_, Response) = try await URLSession.shared.data(for: request)
            if let httpResponse = Response as? HTTPURLResponse {
                if (200...299).contains(httpResponse.statusCode) {
                    print("Success: Activity is created.")
                } else {
                    print("Error status code: \(httpResponse.statusCode)")
                }
            }
        } catch {
            print("Error request Activity: \(error.localizedDescription)")
        }
    }
    
    // ACTIVITY RESPONSE (USER)
    func fetchCActivities(token: String) async {
        guard let url = URL(string: "http://127.0.0.1:8080/activities/current") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let decodedActivities = try decoder.decode([ActivityResponse].self, from: data)
            activities = decodedActivities
        } catch {
            print("Error: fetching or decoding data (activities): \(error)")
        }
    }
}
