//
//  zakfitApp.swift
//  zakfit
//
//  Created by alize suchon on 24/11/2025.
//

import SwiftUI

@main
struct zakfitApp: App {
    
    @State private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            if !appState.isLoggedIn {
                LoginView()
                    .environment(appState)
            } else if appState.isOnboardingNeeded {
                OnboardingView()
                    .environment(appState)
            } else {
                TabBarView()
                    .environment(appState)
            }
        }
    }
}

