//
//  RecapDishCardView.swift
//  zakfit
//
//  Created by alize suchon on 27/11/2025.
//

import SwiftUI

struct RecapMealCardView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.gris)
                .cornerRadius(15)
            HStack (spacing: 25){
                Image("diner")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding(.leading, 20)
                Text("Dîner")
                    .font(.custom("Parkinsans-SemiBold", size: 16 ))
                Spacer()
                VStack{
                    Image("flamme-fill")
                    Text("320 Kcal")
                }
                .padding(.trailing, 20)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 100)
        .padding(.horizontal, 17)
    }
}

#Preview {
    RecapMealCardView()
}
