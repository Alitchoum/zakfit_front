//
//  PickerView.swift
//  zakfit
//
//  Created by alize suchon on 30/11/2025.
//

import SwiftUI

struct PickerView: View {
    
    @Environment(AppState.self) var appState
    @State var selectedView = 0
    
    var body: some View {
        VStack(){
            Text("Historique globale")
                .font(.custom("Parkinsans-SemiBold", size: 25))
                .padding(.bottom, 20)
               
            Picker("", selection: $selectedView) {
                Text("Mois").tag(0)
                Text("Semaine").tag(1)
                
            }
            .padding(.horizontal, 17)
            .pickerStyle(.segmented)
            
            if selectedView == 0 {
                MonthView()
            } else {
                WeekView()
            }
            Spacer()
        }
    }
}

#Preview {
    PickerView()
        .environment(AppState())
}
