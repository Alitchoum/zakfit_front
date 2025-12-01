//
//  AppState.swift
//  zakfit
//
//  Created by alize suchon on 26/11/2025.
//

import SwiftUI

//-> Gere état global (token, user, onboarding, login/logout)

@Observable
final class AppState {
    
    var token: String? {
        didSet {
            if let token {
                UserDefaults.standard.set(token, forKey: "userToken")
            } else {
                UserDefaults.standard.removeObject(forKey: "userToken")
            }
        }
    }
    
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
    
    var isLoggedIn: Bool {
        token != nil && user != nil
    }
    
    var isOnboardingNeeded: Bool {
        get {
            UserDefaults.standard.bool(forKey: "isOnboardingNeeded")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isOnboardingNeeded")
        }
    }
    
    init() {
        self.token = UserDefaults.standard.string(forKey: "userToken")
        
        if let data = UserDefaults.standard.data(forKey: "currentUser"),
           let user = try? JSONDecoder().decode(User.self, from: data) {
            self.user = user
        }
        
        // Si token existe mais pas d'user, le charger
        if token != nil && user == nil {
            Task {
                await loadCurrentUser()
            }
        }
    }
    
    func login(user: User, token: String, needsOnboarding: Bool = false) {
        self.user = user
        self.token = token
        self.isOnboardingNeeded = needsOnboarding
    }
    
    func logout() {
        self.user = nil
        self.token = nil
        self.isOnboardingNeeded = false
    }
    
    func completeOnboarding() {
        self.isOnboardingNeeded = false
    }
    
    func loadCurrentUser() async {
        guard let token = token else { return }
        
        do {
            let fetchedUser = try await UserService.getCurrentUser(token: token)
            self.user = fetchedUser
        } catch {
            print("Erreur chargement user: \(error)")
            logout()
        }
    }
}
