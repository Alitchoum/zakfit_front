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
            VStack(alignment: .leading){
                
                Text(food.name)
                    .font(.custom("Parkinsans-SemiBold", size: 17))
                
                Text("Quantité : \(food.quantity)g")
                    .foregroundColor(.gray)
                    .padding(.bottom, 20)
                
                HStack(spacing:15){
                    //Calories
                    HStack(spacing:7){
                        Circle()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.violet)
                        Text("\(String(format: "%.0f", food.proteins))Kcls")
                    }
                    
                    //Proteins
                    HStack{
                        Circle()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.rose)
                        Text("\(String(format: "%.0f", food.proteins))g")
                    }
                    //Lipides = fats
                    HStack{
                        Circle()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.vert)
                        Text("\(String(format: "%.0f",food.fats))g")
                    }
                    
                    //Glucides = carbs
                    HStack{
                        Circle()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.bleu)
                        Text("\(String(format: "%.0f", food.carbs))g")
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 130)
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


