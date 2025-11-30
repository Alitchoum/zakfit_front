//
//  AddMealTypeView.swift
//  zakfit
//
//  Created by alize suchon on 28/11/2025.
//

import SwiftUI

struct AddMealView : View {
    
    @State var selectedMeal = ""
    
    let mealArray = MealArray
    
    var body: some View {
        VStack {
            
            VStack {
                Rectangle()
                    .foregroundColor(.black)
                    .cornerRadius(15)
                    .frame(width: 50, height: 6)
                    .padding(.bottom, 30)
                    .padding(.top, 20)
                
                Text("Ajouter un repas")
                    .font(.custom("Parkinsans-SemiBold", size: 25))
                    .padding(.bottom, 30)
                
                VStack(spacing:8){
                    //LIGNE 1
                    HStack{
                        //BREAKFAST
                        ZStack{
                            Rectangle()
                                .foregroundColor(mealArray[0].color)
                                .cornerRadius(15)
                                .frame( height: 160)
                            VStack(spacing: 20){
                                Image(mealArray[0].image)
                                    .resizable()
                                    .frame(width: 64, height: 64)
                                Text(mealArray[0].name)
                                    .font(.custom("Parkinsans-Medium", size: 17))
                            }
                        }
                        //DEJEUNER
                        ZStack{
                            Rectangle()
                                .foregroundColor(mealArray[1].color)
                                .cornerRadius(15)
                                .frame( height: 160)
                            VStack(spacing: 20){
                                Image(mealArray[1].image)
                                    .resizable()
                                    .frame(width: 64, height: 64)
                                Text(mealArray[1].name)
                                    .font(.custom("Parkinsans-Medium", size: 17))
                            }
                        }
                    }
                    //LIGNE 2
                    HStack{
                        //COLLATION
                        ZStack{
                            Rectangle()
                                .foregroundColor(mealArray[2].color)
                                .cornerRadius(15)
                                .frame( height: 160)
                            VStack(spacing: 20){
                                Image(mealArray[2].image)
                                    .resizable()
                                    .frame(width: 64, height: 64)
                                Text(mealArray[2].name)
                                    .font(.custom("Parkinsans-Medium", size: 17))
                            }
                        }
                        //DINER
                        ZStack{
                            Rectangle()
                                .foregroundColor(mealArray[3].color)
                                .cornerRadius(15)
                                .frame( height: 160)
                            VStack(spacing: 20){
                                Image(mealArray[3].image)
                                    .resizable()
                                    .frame(width: 64, height: 64)
                                Text(mealArray[3].name)
                                    .font(.custom("Parkinsans-Medium", size: 17))
                            }
                        }
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 17)
        }
    }
}

#Preview {
    AddMealView()
}

