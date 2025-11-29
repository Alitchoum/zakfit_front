//
//  CreateActivity.swift
//
//
//  Created by alize suchon on 26/11/2025.
//

import SwiftUI

struct AddActivityView : View {
    
    @State private var isShowingSheet = false
    
    var body: some View {
        VStack {
            
            Button(action: {
                isShowingSheet.toggle()
            }) {
                Text("BUTTON")
            }
            .sheet(isPresented: $isShowingSheet) {
                VStack {
                    Text("Ajouter un repas")
                        .font(.title)
                        .padding(50)
                    
                    .padding(50)
                    Button("Dismiss",
                           action: { isShowingSheet.toggle() })
                }
            }
        }
    }
}
    #Preview {
        AddActivityView()
    }
    
    
