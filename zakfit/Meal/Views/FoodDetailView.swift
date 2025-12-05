//
//  FoodView.swift
//  zakfit
//
//  Created by alize suchon on 30/11/2025.
//

import SwiftUI

struct FoodDetailView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Bindable var viewModel: MealViewModel
    
    let food: FoodResponse
    @State private var quantityText: String = ""
    let nutriArray = foodModelArray
    
    @State private var columns =
    [GridItem(.flexible()),
     GridItem(.flexible())]
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text(food.name)
                .font(.custom("Parkinsans-SemiBold", size: 24))
                .padding(.top, 30)
                .padding(.bottom, 20)
            
            //ADD QUANTITY
            HStack {
                TextField("0", text: $quantityText)
                    .padding(.horizontal, 20)
                    .frame(height: 50)
                    .background(.gris)
                    .cornerRadius(15)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.numberPad)
                Spacer()
                ZStack{
                    Rectangle()
                        .foregroundColor(.black)
                        .cornerRadius(15)
                        .frame(width: 140)
                    Text("Quantité (g)")
                        .font(.custom("Parkinsans-Medium", size: 16))
                        .foregroundColor(.white)
                }
                .frame(height: 50)
            }
            
            HStack {
                Text("Apports nutritionnels")
                    .font(.custom("Parkinsans-Medium", size: 20))
                Spacer()
            }
           
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
            
            Button {
                guard let quantity = Int(quantityText) else { return }
                
                let factor = Double(quantity) / 100.0
                let foodInMeal = FoodInMealResponse(
                    id: food.id,
                    name: food.name,
                    quantity: quantity,
                    calories: food.calories100g * factor,
                    carbs: food.carbs100g * factor,
                    proteins: food.proteins100g * factor,
                    fats: food.fats100g * factor
                )
                
                //TEMP LIST
                viewModel.foodsInMeal.append(foodInMeal)
                dismiss()
            } label: {
                ZStack {
                    Rectangle()
                        .foregroundColor(.black)
                        .cornerRadius(15)
                    Text("Ajouter")
                        .font(.custom("Parkinsans-Medium", size: 16))
                        .foregroundColor(.white)
                }
                .frame(height: 50)
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
    }
}

#Preview {
    FoodDetailView(
        viewModel: MealViewModel(),
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
