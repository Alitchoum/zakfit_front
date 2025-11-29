//
//  LoginViewModel.swift
//  zakfit
//
//  Created by alize suchon on 27/11/2025.
//

//→ S’occupe du formulaire de login
//→ Appelle UserService
//→ Met à jour AppState

import SwiftUI

@Observable
final class LoginViewModel {
    
    var email: String = ""
    var password: String = ""
    var errorMessage: String?
    var isLoading = false
    var isLoggedIn = false
    
    var appState: AppState
    
    init(appState: AppState) {
        self.appState = appState
    }
    
    func login() async {
        isLoading = true
        errorMessage = nil
        
        //verif champs
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Veuillez remplir tous les champs."
            isLoading = false
            return
        }
        
        do {
            let response = try await UserService.login(
                email: email,
                password: password
            )
            //Enregistrer le token + prévenir l’app que l’utilisateur est connecté
            await MainActor.run {
                appState.login(
                    user: response.user,
                    token: response.token
                )
            }
            
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
}

