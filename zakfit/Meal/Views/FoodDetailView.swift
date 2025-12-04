//
//  FoodView.swift
//  zakfit
//
//  Created by alize suchon on 30/11/2025.
//

import SwiftUI

struct FoodDetailView: View {
    
    @Environment(AppState.self) private var appState
    @Environment(\.dismiss) private var dismiss
    @State var viewModel :  MealViewModel
    
    let nutriArray = foodModelArray
    
    @State private var columns = [GridItem(.flexible()), GridItem(.flexible())]
    @State var quantityText = ""
    
    var mealID: UUID
    var food: FoodResponse
    
    var body: some View {
        VStack{
            Text(food.name)
                .font(.custom("Parkinsans-SemiBold", size: 25))
                .padding(.bottom, 25)
                .padding(.top, 30)
            
            VStack(alignment: .leading){
             
                //QUANTITY
                HStack{
                    TextField("Quantité consommée", text: $quantityText)
                        .padding(.horizontal, 20)
                        .frame(height: 50)
                        .background(.gris)
                        .cornerRadius(15)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.numberPad)
                    
                    ZStack{
                        Rectangle()
                            .foregroundColor(.black)
                            .cornerRadius(15)
                            .frame(width: 90)
                        Text("g")
                            .font(.custom("Parkinsans-Medium", size: 16))
                            .foregroundColor(.white)
                    }
                    .frame(height: 50)
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom, 20)
                
                Text("Apports nutritionnels")
                    .font(.custom("Parkinsans-Medium", size: 20))
                    .padding(.bottom, 20)
                
                //GRILLE NUTRIMENTS
                LazyVGrid(columns: columns, spacing: 10){
                    ForEach (nutriArray) { item in
                        
                        ZStack(alignment: .topLeading){
                            Rectangle()
                                .fill(item.back)
                                .frame(height: 150)
                                .cornerRadius(15)
                            
                            //FORME IMBRIQÉE
                            Image("shape")
                                .resizable()
                                .scaledToFill()
                                .offset(x: 85, y: -50)
                                .frame(height: 150)
                                .clipped()
                            
                            VStack(alignment: .leading){
                                ZStack{
                                    Rectangle()
                                        .cornerRadius(15)
                                        .frame(width: 50, height: 50)
                                        .foregroundColor(item.color)
                                    //PICTO
                                    Image(item.picto)
                                        .resizable()
                                        .frame(width: 27, height: 27)
                                }
                                .padding(.bottom, 15)
                                
                                VStack(spacing: 2){
                                    Text(item.name)
                                        .font(.system(size: 16))
                                        .foregroundColor(.black)
                                    Text("\(calculApport(food: food, nutriment: item.name, quantite: Int(quantityText) ?? 0)) g")
                                        .font(.custom("Parkinsans-SemiBold", size: 20))
                                        .foregroundColor(.black)
                                }
                            }
                            .padding(.leading, 20)
                            .padding(.top, 15)
                        }
                    }
                }
                
                //BUTTON ADD FOOD
                Button{
                    Task {
                        if let token = appState.token,
                        let quantity = Int(quantityText){
                            await viewModel.addFoodToMeal(token: token, mealID: mealID, foodID: food.id, quantity: quantity)
                            await viewModel.fetchMealDetails(token: token, mealID: mealID)
                            dismiss()
                        } else {
                            print("Error adding food to meal")
                        }
                    }
                            
                }label: {
                    ZStack{
                        Rectangle()
                            .foregroundColor(.black)
                            .cornerRadius(15)
                        Text("Ajouter")
                            .font(.custom("Parkinsans-Medium", size: 16))
                            .foregroundColor(.white)
                    }
                    .frame(height: 50)
                }
                .padding(.top, 15)
            }
        }
        .padding(.horizontal, 17)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
    }
}

#Preview {
    FoodDetailView(
        viewModel: MealViewModel(),
        mealID: UUID(),
        food: FoodResponse(
            id: UUID(),
            name: "Banane",
            calories100g: 20,
            carbs100g: 45,
            fats100g: 20,
            proteins100g: 50,
            isCustom: false,
            foodCategoryID: UUID()
        )
    )
    .environment(AppState())
}
