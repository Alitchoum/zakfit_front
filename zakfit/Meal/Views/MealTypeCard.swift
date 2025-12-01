//
//  AddTypeCard.swift
//  zakfit
//
//  Created by alize suchon on 01/12/2025.
//

import SwiftUI

struct MealTypeCard: View {
    
    let type: MealType
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(type.color)
                .cornerRadius(15)
                .frame(height: 160)
            
            VStack(spacing: 20) {
                Image(type.picto)
                    .resizable()
                    .frame(width: 64, height: 64)
                
                Text(type.name)
                    .font(.custom("Parkinsans-Medium", size: 17))
                    .foregroundColor(.black)
            }
        }
    }
}

#Preview {
    MealTypeCard(type: MealType(
        name: "Déjeuner",
        picto: "dej",
        color: .vert
    ))
}
