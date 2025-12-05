//
//  HistoriqueView.swift
//  zakfit
//
//  Created by alize suchon on 30/11/2025.
//

import SwiftUI

struct WeekView: View {
    
    @Environment(AppState.self) var appState
    
    var body: some View {
        VStack{
            Text("Date")
                .font(.custom("Parkinsans-Medium", size: 20))
                .padding(.bottom, 20)
        }
    }
}

#Preview {
    WeekView()
        .environment(AppState())
}
