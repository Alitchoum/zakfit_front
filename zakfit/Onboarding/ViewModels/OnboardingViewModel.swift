//
//  OnboardingViewModel.swift
//  zakfit
//
//  Created by alize suchon on 28/11/2025.
//

import SwiftUI

struct UserUpdateDTO: Codable {
    var weight: Int
    var size: Int
    var gender: String
    var objective: String
    var diet: String
    var birthday: Date
}

@Observable
final class OnboardingViewModel {
    
    var currentPage = 0
    var NbPage = 5
    
    var weight: Int = 0
    var size: Int = 0
    var gender: String = ""
    var objective: String = ""
    var diet: String = ""
    var birthday: Date = Date()
    
    var errorMessage: String?
    
    //MARK: - FUNCTIONS NAVIGATION
    
    func nextPage() {
        if currentPage < NbPage - 1 {
            currentPage += 1
        }
    }
    
    func previousPage() {
        if currentPage >= 0 {
            currentPage -= 1
        }
    }
    
    func progress() -> Double {
        CGFloat(currentPage) / Double(NbPage - 1)
    }
    
    //MARK: - FUNCTIONS CHECK DATAS BY VIEW
    
    func okForNext(current: Int) -> Bool {
        switch currentPage {
        case 0:
            return birthday < Date()
        case 1:
            return size > 100 && size < 300 && weight > 0 && weight < 300
        case 2:
            return !gender.isEmpty
        case 3:
            return !objective.isEmpty
        case 4:
            return !diet.isEmpty
        default :
            return false
        }
    }
    
    func ViewMessage(current: Int) -> String {
        switch currentPage {
        case 0:
            return "Veuillez choisir votre date de naissance"
        case 1:
            return "Veuillez saisir des valeurs valides"
        case 2:
            return "Veuillez  sélectionner un genre"
        case 3:
            return "Veuillez  sélectionner un objectif"
        case 4:
            return "Veuillez sélectionner un regime alimentaire"
        default :
            return ""
        }
    }
    
    //MARK: - SEND DATA TO API
    func updateDataUser(token: String)  async  {
        guard let url = URL(string: "http://127.0.0.1:8080/users/profile") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let updateData = UserUpdateDTO(
            weight: weight,
            size: size,
            gender: gender,
            objective: objective,
            diet: diet,
            birthday: birthday
        )
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        request.httpBody = try? encoder.encode(updateData)
        
        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse {
                if (200...299).contains(httpResponse.statusCode) {
                    print("Success: user is update.")
                } else {
                    print("Error status code: \(httpResponse.statusCode)")
                }
            }
        } catch {
            print("Error request user update: \(error.localizedDescription)")
        }
    }
}
