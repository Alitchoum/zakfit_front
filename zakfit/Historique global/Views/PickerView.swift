//
//  PickerView.swift
//  zakfit
//
//  Created by alize suchon on 30/11/2025.
//

import SwiftUI

struct PickerView: View {
    
    @State var selectedView = 0
    
    var body: some View {
        VStack(){
            Text("Historique globale")
                .font(.custom("Parkinsans-SemiBold", size: 25))
                .padding(.bottom, 30)
            Picker("", selection: $selectedView) {
                Text("Semaine").tag(0)
                Text("Mois").tag(1)
            }
            .padding(.horizontal, 17)
            .pickerStyle(.segmented)
            if selectedView == 0 {
                WeekView()
            } else {
                MonthView()
            }
        }
    }
}

#Preview {
    PickerView()
}
