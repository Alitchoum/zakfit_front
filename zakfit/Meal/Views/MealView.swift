//
//  MealView.swift
//  zakfit
//
//  Created by alize suchon on 24/11/2025.
//

import SwiftUI

struct MealView: View {
    
    @Environment(AppState.self) private var appState
    @Environment(\.dismiss) private var dismiss
    @Bindable var viewModel: MealViewModel
    @State private var showAlert = false
    
    let mealType: MealType
    
    var totalCalories: Double {
        viewModel.foodsInMeal.reduce(0) { $0 + $1.calories }
    }
    
    var totalProteins: Double {
        viewModel.foodsInMeal.reduce(0) { $0 + $1.proteins }
    }
    
    var totalFats: Double {
        viewModel.foodsInMeal.reduce(0) { $0 + $1.fats }
    }
    
    var totalCarbs: Double {
        viewModel.foodsInMeal.reduce(0) { $0 + $1.carbs }
    }
    
    var mealInfos: [MealModel] {
        [
            .init(type: "Calories", value: totalCalories, color: .violet, picto: "fire"),
            .init(type: "Protéines", value: totalProteins, color: .rose, picto: "fish-simple"),
            .init(type: "Lipides", value: totalFats, color: .vert, picto: "ble"),
            .init(type: "Glucides", value: totalCarbs, color: .bleu, picto: "avocado")
        ]
    }
    
    var onSave: (() -> Void)? = nil
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            Text(mealType.name)
                .font(.custom("Parkinsans-SemiBold", size: 25))
            
            // NUTRI TOTAUX
            HStack(spacing: 7) {
                ForEach(mealInfos) { info in
                    ZStack {
                        Rectangle()
                            .frame(height: 130)
                            .cornerRadius(15)
                            .foregroundColor(info.color)
                        VStack {
                            ZStack{
                                Circle()
                                    .frame(width: 45, height: 45)
                                    .foregroundColor(.white.opacity(0.5))
                                Image(info.picto)
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                
                            }
                            VStack(spacing: 2) {
                                Text("\(String(format: "%.1f", info.value))")
                                    .font(.custom("Parkinsans-SemiBold", size: 18))
                                Text(info.type)
                                    .font(.system(size: 14))
                            }
                            .padding(.top, 2)
                        }
                    }
                }
            }
            .padding(.horizontal, 17)
            
            // LISTE PRODUITS
            HStack {
                Text("Produits alimentaires")
                    .font(.custom("Parkinsans-Medium", size: 20))
                Spacer()
                
                NavigationLink(destination: AddFoodInMeal(viewModel: viewModel)) {
                    Image("plus")
                }
            }
            .padding(.horizontal, 17)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    
                    // LISTE ALIMENTS
                    if viewModel.foodsInMeal.isEmpty {
                        Text("Aucun aliment ajouté")
                            .foregroundColor(.gray)
                            .font(.system(size: 16))
                            .padding(.top, 10)
                    } else {
                        VStack(spacing: 8) {
                            ForEach(viewModel.foodsInMeal) { foodItem in
                                FoodInMealCardView(food: foodItem)
                            }
                        }
                    }
                    
                    // BOUTON SAVE
                    if viewModel.foodsInMeal.isEmpty {
                        ZStack {
                            Rectangle()
                                .foregroundColor(.gray)
                                .cornerRadius(15)
                                .frame(height: 50)
                            Text("Enregistrer le repas")
                                .font(.custom("Parkinsans-Medium", size: 16))
                                .foregroundColor(.white)
                        }
                    } else {
                        Button {
                            Task {
                                guard let token = appState.token else {
                                    print("Error: No token")
                                    return
                                }
                                //CREATE MEAL
                                guard let createdMeal = await viewModel.sendCreateMeal(
                                    token: token,
                                    type: mealType.name
                                ) else {
                                    print("Error: Failed to create meal")
                                    return
                                }
                                
                                //ADD FOOD IN MEAL
                                for food in viewModel.foodsInMeal {
                                    await viewModel.addFoodToMeal(
                                        token: token,
                                        mealID: createdMeal.id,
                                        foodID: food.id,
                                        quantity: food.quantity
                                    )
                                }
                                showAlert = true
                            }
                        } label: {
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.black)
                                    .cornerRadius(15)
                                    .frame(height: 50)
                                Text("Enregistrer le repas")
                                    .font(.custom("Parkinsans-Medium", size: 16))
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.bottom, 20)
                        .alert("Repas enregistré avec succès 😋", isPresented: $showAlert) {
                            Button("OK", role: .cancel) {
                                onSave?()
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 17)
        }
    }
}

#Preview {
    MealView(viewModel: MealViewModel(),
             mealType: MealType(
                name: "Déjeuner",
                picto: "dej",
                color: .vertC
             ))
    .environment(AppState())
}
