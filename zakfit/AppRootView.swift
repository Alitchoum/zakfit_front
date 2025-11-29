//
//  ContentView.swift
//  zakfit
//
//  Created by alize suchon on 24/11/2025.
//

import SwiftUI


struct AppRootView: View {

    @Environment(AppState.self) var appState

    var body: some View {
        Group {  // ✅ Pas besoin de NavigationStack ici ??
            if !appState.isLoggedIn {
                RegisterView()
            }
            else if appState.isOnboardingNeeded {
                OnboardingView()
            }
            else {
                TabBarView()
            }
        }
    }
}

#Preview {
    AppRootView()
}
