//
//  zakfitApp.swift
//  zakfit
//
//  Created by alize suchon on 24/11/2025.
//

import SwiftUI

@main
struct zakfitApp: App {
    
    @State var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            AppRootView()
                .environment(appState)
        }
    }
}
