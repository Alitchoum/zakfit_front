//
//  tabar.swift
//  zakfit
//
//  Created by alize suchon on 24/11/2025.
//

import SwiftUI
import Observation

struct TabBarView: View {
    
    @State private var selectedTab = 0
    
    var body: some View {
    
        TabView(selection: $selectedTab) {
           
            NavigationStack { DashboardView() }
                    .tabItem {
                        Image(selectedTab == 0 ? "home-fill" : "home")
                        Text("Accueil")
                    }
                    .tag(0)
                
            NavigationStack { MealView() }
                    .tabItem {
                        Image(selectedTab == 1 ? "carrot-fill" : "carrot")
                        Text("Repas")
                    }
                    .tag(1)
                
            NavigationStack { ActivityView() }
                    .tabItem {
                        Image(selectedTab == 2 ? "lightning-fill" : "lightning")
                        Text("Sport")
                    }
                    .tag(2)
                
            NavigationStack { ProfilView() }
                    .tabItem {
                        Image(selectedTab == 3 ? "smiley-fill" : "smiley")
                        Text("Profil")
                    }
                    .tag(3)
            }
            .tint(.black)
        }
    }

#Preview {
    TabBarView()
        .environment(AppState())
       
}
