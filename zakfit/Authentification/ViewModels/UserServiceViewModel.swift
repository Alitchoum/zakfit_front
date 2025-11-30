//
//  UserServiceViewModel.swift
//  zakfit
//
//  Created by alize suchon on 27/11/2025.
//

import SwiftUI

//-> Connexion avec API
//-> login / getCurrentUser

struct LoginResponse: Codable {
    let token: String
    let user: User
}

final class UserService {
    
    //Recupere l'utilisateur connecté depuis API
    static func getCurrentUser(token: String) async throws -> User {
        guard let url = URL(string: "http://127.0.0.1:8080/users/profile") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601 //pour date
        
        let user = try decoder.decode(User.self, from: data)
        return user
    }
    
    //LOGIN
    static func login(email: String, password: String) async throws -> LoginResponse {
        guard let url = URL(string: "http://127.0.0.1:8080/auth/login") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = [
            "email": email,
            "password": password
        ]
        
        request.httpBody = try JSONEncoder().encode(body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        guard (200..<300).contains(httpResponse.statusCode) else {
            let message = String(data: data, encoding: .utf8) ?? "Erreur serveur"
            throw NSError(
                domain: "",
                code: httpResponse.statusCode,
                userInfo: [NSLocalizedDescriptionKey: message]
            )
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601 // date !!!!
        let loginResponse = try decoder.decode(LoginResponse.self, from: data)
        
        return loginResponse
    }
}
