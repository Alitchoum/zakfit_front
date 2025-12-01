//
//  MealView.swift
//  zakfit
//
//  Created by alize suchon on 24/11/2025.
//

import SwiftUI

struct MealView: View {
    
    let textArray = arrayInfos
    var selectedMealType: MealType? = nil
    
    var body: some View {
        NavigationStack{
            VStack{
                Text("Dîner")
                    .font(.custom("Parkinsans-SemiBold", size: 24))
                
                ZStack{
                    Rectangle()
                        .ignoresSafeArea()
                        .foregroundColor(.gray)
                        .frame(height: 295)
                    VStack{
                        Image("photo")
                            .resizable()
                            .frame(width: 35, height: 35)
                    }
                }
                VStack(alignment: .leading, spacing: 20){
                    HStack{
                        ForEach(textArray) { item in
                            ZStack{
                                Rectangle()
                                    .frame(height: 90)
                                    .cornerRadius(15)
                                    .foregroundColor(item.color)
                                VStack(spacing: 5){
                                    Text("\(item.value)g")
                                        .font(Font.custom("Parkinsans-SemiBold", size: 20))
                                    Text(item.type)
                                        .font(.system(size: 14))
                                }
                            }
                        }
                    }
                    
                    HStack{
                        Text("Produits alimentaires")
                            .font(.custom("Parkinsans-Medium", size: 20))
                        Spacer()
                        NavigationLink(destination: AddFoodInMeal()){
                            Image("plus")
                            
                        }
                    }
                }
                .padding(.horizontal, 17)
            }
        }
    }
}

#Preview {
    MealView()
}
