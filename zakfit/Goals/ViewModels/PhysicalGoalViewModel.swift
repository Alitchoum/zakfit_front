//
//  PhysicalGoalViewModel.swift
//  zakfit
//
//  Created by alize suchon on 03/12/2025.
//

import SwiftUI

struct PhysicalGoalDTO: Codable {
    let duration: Int?
    let frequency: Int?
    let caloriesBurned: Double?
}

@Observable
final class PhysicalGoalViewModel {
    
    var physicalGoal: PhysicalGoalDTO?
    
    //FETCH PHYSICAL GOAL
    func fetchPhysicalGoal(token: String, duration: Int?, frequency: Int?, caloriesBurned: Double?) async {
        guard let url = URL(string: "http://127.0.0.1:8080/physicalGoal/current") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let newGoal = PhysicalGoalDTO(
            duration: duration,
            frequency: frequency,
            caloriesBurned: caloriesBurned
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
    
    //GET USER PHYSICAL GOAL
    func getPhysicalGoal(token: String) async{
        
        guard let url = URL(string: "http://127.0.0.1:8080/physicalGoal/current") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) {
                let decoder = JSONDecoder()
                let goal = try decoder.decode(PhysicalGoalDTO.self, from: data)
                physicalGoal = goal
                
                print("Succes : Goal fetched")
                
            } else {
                print("Error fetching goal: \(response)")
            }
        } catch {
            print("Error: \(error)")
        }
    }
    
    //PROGRESS BAR
    func sportProgressBar(current: Double, target: Double, maxWidth: CGFloat) -> CGFloat {
          guard target > 0 else { return 0 }
          return min(current / target, 1.0) * maxWidth
      }
}
