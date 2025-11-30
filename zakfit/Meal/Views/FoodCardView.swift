//
//  FoodCardView.swift
//  zakfit
//
//  Created by alize suchon on 27/11/2025.
//

import SwiftUI

struct FoodCardView: View {
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.gris)
                .cornerRadius(15)
            VStack(alignment: .leading){
                
                Text("Banane")
                    .font(.custom("Parkinsans-SemiBold", size: 16))
                
                Text("Quantié 100g")
                    .foregroundColor(.gray)
                    .padding(.bottom, 20)
                
                HStack(spacing:15){
                    //Calories
                    HStack(spacing:7){
                        Circle()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.violet)
                        Text("100cals")
                    }
                    
                    //Proteins
                    HStack{
                        Circle()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.rose)
                        Text("100g")
                    }
                    
                    //Lipides : fats
                    HStack{
                        Circle()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.vert)
                        Text("100g")
                    }
                    
                    //Glucides : carbs
                    HStack{
                        Circle()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.bleu)
                        Text("100g")
                    }
                }
                    
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 130)
        .padding(.horizontal, 17)
    }
}


#Preview {
    FoodCardView()
}
