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
    @State private var viewModel = MealViewModel()
    @State private var showAlert = false
        
    let mealID: UUID
    let mealType: MealType
    let textArray = arrayInfos
    
    var onSave: (() -> Void)? = nil
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            //TITRE
            Text(mealType.name)
                .font(.custom("Parkinsans-SemiBold", size: 25))
            
            //NUTRI TOTAUX
            HStack {
                ForEach(textArray) { item in
                    ZStack {
                        Rectangle()
                            .frame(height: 90)
                            .cornerRadius(15)
                            .foregroundColor(item.color)
                        VStack(spacing: 5) {
                            Text("\(item.value)g")
                                .font(.custom("Parkinsans-SemiBold", size: 20))
                            Text(item.type)
                                .font(.system(size: 14))
                        }
                    }
                }
            }
            .padding(.horizontal, 17)
            
            
            //LISTE PRODUITS
            HStack {
                Text("Produits alimentaires")
                    .font(.custom("Parkinsans-Medium", size: 20))
                Spacer()
                
                NavigationLink(destination: AddFoodInMeal(viewModel: viewModel, mealID: mealID)) {
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
                        VStack(spacing: 15) {
                            ForEach(viewModel.foodsInMeal) { foodItem in
                                FoodInMealCardView(food: foodItem)
                            }
                        }
                    }
                    
                    // BOUTON SAVE
                    Button {
                        Task {
                            guard let token = appState.token else { return }
                            await viewModel.refreshMeal(token: token, mealID: mealID)
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
                    .padding(.horizontal, 17)
                    .padding(.bottom, 20)
                    .alert("Repas enregistré avec succès 😋​", isPresented: $showAlert) {
                        Button("OK", role: .cancel) { onSave?() }
                    }
                }
            }
            .padding(.horizontal, 17)
        }
        .task {
            guard let token = appState.token else { return }
            await viewModel.fetchMealDetails(token: token, mealID: mealID)
        }
    }
}

#Preview {
    MealView(mealID: UUID(), mealType: MealType(
        name: "Déjeuner",
        picto: "dej",
        color: .vertC
    ))
    .environment(AppState())
}
