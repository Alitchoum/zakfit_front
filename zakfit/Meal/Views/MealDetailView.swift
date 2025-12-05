//
//  MealDetailView.swift
//  zakfit
//
//  Created by alize suchon on 04/12/2025.
//

import SwiftUI

struct MealDetailView: View {
    
    @Environment(AppState.self) private var appState
    @State var viewModel: MealViewModel
    let mealID: UUID
    
    var meal: MealResponseDTO? {
        viewModel.currentMeal
    }
    
    var body: some View {
        VStack(spacing: 20) {
            if let meal {
                Text(meal.type)
                    .font(.custom("Parkinsans-SemiBold", size: 25))
                
                // NUTRI TOTAUX
                HStack(spacing: 7) {
                    // Calories
                    ZStack {
                        Rectangle()
                            .frame(height: 130)
                            .cornerRadius(15)
                            .foregroundColor(.violet)
                        
                        VStack{
                            ZStack{
                                Circle()
                                    .frame(width: 45, height: 45)
                                    .foregroundColor(.white.opacity(0.5))
                                Image("fire")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                
                            }
                            VStack(spacing: 5) {
                                Text("\(String(format: "%.1f", meal.totalCalories))")
                                    .font(.custom("Parkinsans-SemiBold", size: 18))
                                Text("Calories")
                                    .font(.system(size: 14))
                            }
                        }
                        .padding(.top, 2)
                    }
                    // Proteins
                    ZStack {
                        Rectangle()
                            .frame(height: 130)
                            .cornerRadius(15)
                            .foregroundColor(.rose)
                        
                        VStack{
                            ZStack{
                                Circle()
                                    .frame(width: 45, height: 45)
                                    .foregroundColor(.white.opacity(0.5))
                                Image("fish-simple")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                
                            }
                            VStack(spacing: 5) {
                                Text("\(String(format: "%.1f", meal.totalProteins))")
                                    .font(.custom("Parkinsans-SemiBold", size: 18))
                                Text("Proteines")
                                    .font(.system(size: 14))
                            }
                        }
                        .padding(.top, 2)
                    }
                    // Lipides
                    ZStack {
                        Rectangle()
                            .frame(height: 130)
                            .cornerRadius(15)
                            .foregroundColor(.vert)
                        
                        VStack{
                            ZStack{
                                Circle()
                                    .frame(width: 45, height: 45)
                                    .foregroundColor(.white.opacity(0.5))
                                Image("ble")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                
                            }
                            VStack(spacing: 5) {
                                Text("\(String(format: "%.1f", meal.totalFats))")
                                    .font(.custom("Parkinsans-SemiBold", size: 18))
                                Text("Lipides")
                                    .font(.system(size: 14))
                            }
                        }
                        .padding(.top, 2)
                    }
                    // Glucides
                    ZStack {
                        Rectangle()
                            .frame(height: 130)
                            .cornerRadius(15)
                            .foregroundColor(.bleu)
                        
                        VStack{
                            ZStack{
                                Circle()
                                    .frame(width: 45, height: 45)
                                    .foregroundColor(.white.opacity(0.5))
                                Image("avocado")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                
                            }
                            VStack(spacing: 5) {
                                Text("\(String(format: "%.1f", meal.totalCarbs))")
                                    .font(.custom("Parkinsans-SemiBold", size: 18))
                                Text("Glucides")
                                    .font(.system(size: 14))
                            }
                        }
                        .padding(.top, 2)
                    }
                }
                
                // Aliments
                HStack {
                    Text("Aliments du repas")
                        .font(.custom("Parkinsans-Medium", size: 20))
                    Spacer()
                }
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 20) {
                        if meal.foods?.isEmpty ?? true {
                            Text("Aucun aliment")
                                .foregroundColor(.gray)
                                .font(.system(size: 16))
                                .padding(.top, 10)
                        } else {
                            VStack(spacing: 8) {
                                ForEach(meal.foods ?? []) { food in
                                    FoodInMealCardView(food: food)
                                }
                            }
                        }
                    }
                }
                
            } else {
                ProgressView("Chargement...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .padding(.horizontal, 17)
        .task {
            guard let token = appState.token else { return }
            await viewModel.fetchMealDetails(token: token, mealID: mealID)
        }
    }
}

#Preview {

    MealDetailView(viewModel: MealViewModel(),mealID: UUID())
        .environment(AppState())
}
