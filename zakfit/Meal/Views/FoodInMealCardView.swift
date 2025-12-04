//
//  FoodCardView.swift
//  zakfit
//
//  Created by alize suchon on 27/11/2025.
//

import SwiftUI

struct FoodInMealCardView: View {
    
    var food: FoodInMealResponse
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.gris)
                .cornerRadius(15)
                .frame(height: 132)
            
            VStack(alignment: .leading, spacing: 10){
                Text(food.name)
                    .font(.custom("Parkinsans-SemiBold", size: 17))
                
                Text("Quantité: \(food.quantity) g / Calories: \(Int(food.calories)) Kcls")
                    .foregroundColor(.gray)
                    .padding(.bottom, 10)
                
                HStack{
                    // PROTÉINES
                    HStack(spacing: 10) {
                        Circle()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.rose)
                        Text("\(String(format: "%.1f", food.proteins)) g")
                            .font(Font.custom("Parkinsans-SemiBold", size: 16))
                            .lineLimit(1)
                            .fixedSize(horizontal: true, vertical: false)
                    }
                    Spacer()

                    // LIPIDES
                    HStack(spacing: 10) {
                        Circle()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.vert)
                        Text("\(String(format: "%.1f", food.fats)) g")
                            .lineLimit(1)
                            .fixedSize(horizontal: true, vertical: false)
                            .font(Font.custom("Parkinsans-SemiBold", size: 16))
                    }
                    Spacer()

                    // GLUCIDES
                    HStack(spacing: 10) {
                        Circle()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.bleu)
                        Text("\(String(format: "%.1f", food.carbs)) g")
                            .lineLimit(1)
                            .fixedSize(horizontal: true, vertical: false)
                            .font(Font.custom("Parkinsans-SemiBold", size: 16))
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .padding(20)
        }
    }
}

#Preview {
    FoodInMealCardView(food: FoodInMealResponse(
        id: UUID(),
        name: "Banane",
        quantity: 67,
        calories: 400,
        carbs: 446,
        proteins: 443,
        fats: 142,
    ))
}


