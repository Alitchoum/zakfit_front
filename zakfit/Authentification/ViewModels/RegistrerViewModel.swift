//
//  RegistrerViewModel.swift
//  zakfit
//
//  Created by alize suchon on 26/11/2025.
//

import SwiftUI

//-> S’occupe du formulaire d’inscription
//-> Appelle API
//-> Renvoie le user + token

struct RegisterResponse: Codable {
    let user: User
    let token: String
}

@Observable
final class RegisterViewModel {
    
    var appState: AppState?
    
    init(appState: AppState? = nil) {
        self.appState = appState
    }
    
    var firstName = ""
    var lastName = ""
    var email = ""
    var password = ""
    var confirmPassword = ""
    
    var errorMessage: String?
    var isLoading = false
    var isRegistered = false
    
    var registeredUser: User?
    var receivedToken: String?
    
    // MARK: - Register
    
    func register() async {
        guard validateFields() else { return }
        
        isLoading = true
        errorMessage = nil
        
        do {
            let request = try createRequest()
            let (data, response) = try await URLSession.shared.data(for: request)
            try validateResponse(data: data, response: response)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601 //pour date
            
            // Décode la réponse
            let apiResponse = try decoder.decode(RegisterResponse.self, from: data)
            
            self.registeredUser = apiResponse.user
            self.receivedToken = apiResponse.token
            isRegistered = true
            
        } catch {
            print(" ERROR: \(error)")
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    // MARK: Fonction validation des champs
    private func validateFields() -> Bool {
        guard !firstName.isEmpty,
              !lastName.isEmpty,
              !email.isEmpty,
              !password.isEmpty else {
            errorMessage = "Veuillez remplir tous les champs."
            return false
        }
        
        guard password == confirmPassword else {
            errorMessage = "Les mots de passe ne correspondent pas."
            return false
        }
        
        return true
    }
    
    // MARK: Création de la requête
    private func createRequest() throws -> URLRequest {
        guard let url = URL(string: "http://127.0.0.1:8080/auth/register") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: String] = [
            "firstName": firstName,
            "lastName": lastName,
            "email": email,
            "password": password
        ]
        
        request.httpBody = try JSONEncoder().encode(body)
        return request
    }
    
    // MARK: - Validation de la réponse
    private func validateResponse(data: Data, response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            let message = String(data: data, encoding: .utf8) ?? "Erreur serveur"
            throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: message])
        }
    }
}
