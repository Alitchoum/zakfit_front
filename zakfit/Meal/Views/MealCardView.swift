//
//  RecapDishCardView.swift
//  zakfit
//
//  Created by alize suchon on 27/11/2025.
//

import SwiftUI

struct MealCardView: View {
    
    var meal : MealResponseDTO?
    var typeSelected : String = ""
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.gris)
                .cornerRadius(15)
            HStack (spacing: 25){
                
                //LOGIQUE POUR IMAGE
                var image: String {
                    if meal?.type == "Collation" {
                        return "donut"
                    } else if meal?.type == "Petit-déjeuner" {
                        return "breakfast"
                    } else if meal?.type == "Déjeuner" {
                        return "dej"
                    } else if meal?.type == "Dîner" {
                        return "diner"
                    } else {
                        return "collation"
                    }
                }
                
                Image(image)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding(.leading, 20)
                Text(meal?.type ?? "")
                    .font(.custom("Parkinsans-SemiBold", size: 16 ))
                Spacer()
                VStack{
                    Image("fire-fill")
                    Text("\(Int(meal?.totalCalories ?? 0)) Kcls")
                }
                .padding(.trailing, 20)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 100)
    }

}

#Preview {
    MealCardView(meal: MealResponseDTO(
        id: UUID(),
        type: "Dîner",
        totalCalories: 300,
        totalCarbs: 35,
        totalProteins: 35,
        totalFats: 35,
        date: Date(),
        userId: UUID(),
        foods: nil
    ))
}
