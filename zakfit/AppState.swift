//
//  AppState.swift
//  zakfit
//
//  Created by alize suchon on 26/11/2025.
//

import SwiftUI


//AppState
//→ état global (token, user, onboarding, login/logout)

@Observable
final class AppState {
    
    // MARK:  Token
    var token: String? {
        didSet {
            if let token {
                UserDefaults.standard.set(token, forKey: "userToken")
            } else {
                UserDefaults.standard.removeObject(forKey: "userToken")
            }
        }
    }
    
    // MARK: Contient infos de l'utilisateur
    var user: User? {
        didSet {
            if let user {
                if let encoded = try? JSONEncoder().encode(user) {
                    UserDefaults.standard.set(encoded, forKey: "currentUser")
                }
            } else {
                UserDefaults.standard.removeObject(forKey: "currentUser")
            }
        }
    }
    
    // MARK: Connecter l'utilisateur
    var isLoggedIn: Bool {
        token != nil && user != nil
    }
    
    // MARK:  Verifie s'il faut lancer onBoarding
    var isOnboardingNeeded: Bool {
        get {
            UserDefaults.standard.bool(forKey: "isOnboardingNeeded")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isOnboardingNeeded")
        }
    }
    
    // MARK: -  Init
    init() {
        // Charge le token
        self.token = UserDefaults.standard.string(forKey: "userToken")
        
        // Charge l'utilisateur
        if let data = UserDefaults.standard.data(forKey: "currentUser"),
           let user = try? JSONDecoder().decode(User.self, from: data) {
            self.user = user
        }
        
        // Onboarding par défaut
        if UserDefaults.standard.object(forKey: "isOnboardingNeeded") == nil {
            self.isOnboardingNeeded = true
        }
        
        // Si token existe mais pas d'user, le charger (user)
        if token != nil && user == nil {
            Task {
                await loadCurrentUser()
            }
        }
    }
    
    // MARK: - Methods
    
    //Enregistre token + user + met à jour les vues automatiquement
    func login(user: User, token: String) {
        self.user = user
        self.token = token
    }
    
    func logout() {
        self.user = nil
        self.token = nil
    }
    
    func completeOnboarding() {
           self.isOnboardingNeeded = false
           UserDefaults.standard.set(false, forKey: "isOnboardingNeeded")
       }
    
    func loadCurrentUser() async {
        guard let token = token else { return }
        
        do {
            let fetchedUser = try await UserService.getCurrentUser(token: token)
            self.user = fetchedUser
        } catch {
            print(" Erreur chargement user: \(error)")
            logout()
        }
    }
}
