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
    @State var viewModel : MealViewModel
    @State private var showAlert = false
        
    let mealID: UUID
    let mealType: MealType
    
    var mealInfos: [MealModel] {
        [
            .init(type: "Calories", value: Double(viewModel.currentMeal?.totalCalories ?? 0), color: .violet),
            .init(type: "Protéines", value: Double(viewModel.currentMeal?.totalProteins ?? 0), color: .rose),
            .init(type: "Lipides", value: Double(viewModel.currentMeal?.totalFats ?? 0), color: .vert),
            .init(type: "Glucides", value: Double(viewModel.currentMeal?.totalCarbs ?? 0), color: .bleu)
        ]
    }
    
    var onSave: (() -> Void)? = nil
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            //TITRE
            Text(mealType.name)
                .font(.custom("Parkinsans-SemiBold", size: 25))
            
            //NUTRI TOTAUX
            HStack(spacing: 7){
                ForEach(mealInfos) { info in
                    ZStack {
                        Rectangle()
                            .frame(height: 90)
                            .cornerRadius(15)
                            .foregroundColor(info.color)
                        VStack(spacing: 5) {
                            Text("\(String(format: "%.1f", info.value))")
                                .font(.custom("Parkinsans-SemiBold", size: 18))
                            Text(info.type)
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
                        VStack(spacing: 8) {
                            ForEach(viewModel.foodsInMeal) { foodItem in
                                FoodInMealCardView(food: foodItem)
                            }
                        }
                    }
                    
                    // BOUTON SAVE
                    if viewModel.foodsInMeal.isEmpty{
                        //BUTTON FIXE
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
                        //BUTTON CREATE MEAL
                        Button {
                       
                                Task {
                                        guard let token = appState.token else { return }

                                        // Parcours tous les aliments ajoutés dans le repas
                                        for food in viewModel.foodsInMeal {
                                            await viewModel.addFoodToMeal(
                                                token: token,
                                                mealID: mealID,
                                                foodID: food.id,
                                                quantity: food.quantity
                                            )
                                        }

                                        // Ensuite, tu peux recharger les détails du repas
                                        await viewModel.fetchMealDetails(token: token, mealID: mealID)

                                        // Afficher l'alerte
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
                        .alert("Repas enregistré avec succès 😋​", isPresented: $showAlert) {
                            Button("OK", role: .cancel) { onSave?() }
                        }
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
    MealView(viewModel: MealViewModel(),
             mealID: UUID(), mealType: MealType(
        name: "Déjeuner",
        picto: "dej",
        color: .vertC
    ))
    .environment(AppState())
}
