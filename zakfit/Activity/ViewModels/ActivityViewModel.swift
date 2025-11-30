//
//  ActivityViewModel.swift
//  zakfit
//
//  Created by alize suchon on 30/11/2025.
//

import SwiftUI

struct CategoryResponse: Identifiable, Codable {
    let id: UUID
    let name: String
    let picto: String
}

struct ActivityDTO: Identifiable, Codable {
    let id: UUID
    let duration: Int
    let caloriesBurned: Int
    let date: Date
    let categoryId: UUID
}

@Observable
final class ActivityViewModel {
    
    var categories: [CategoryResponse] = []
    var activities: [ActivityDTO] = []
    
    //FETCH DATAS API
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
//    func sendActivityDTO(activity: ActivityDTO) async {
//        guard let url = URL(string: "http://127.0.0.1:8080/activities/current") else { return }
//        
//        do {
//            let encoder = JSONEncoder()
//           // let encodedActivity = try encoder.encode(ActivityDTO)
//            
//            var request = URLRequest(url: url)
//            request.httpMethod = "POST"
//            
//        }
//    }
}
