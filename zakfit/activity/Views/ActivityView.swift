//
//  activityView.swift
//  zakfit
//
//  Created by alize suchon on 26/11/2025.
//


import SwiftUI

struct ActivityView: View {
    var body: some View {
        VStack(alignment: .leading){
            Text("Mes activités")
                .font(.custom("Parkinsans-SemiBold", size: 24))
                .padding(.bottom, 40)
            
        }
        .padding(.horizontal, 17)
    }
}

#Preview {
    ActivityView()
}
