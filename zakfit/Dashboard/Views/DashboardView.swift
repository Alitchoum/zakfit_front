//
//  DashboardView.swift
//  zakfit
//
//  Created by alize suchon on 24/11/2025.
//

import SwiftUI

struct DashboardView: View {
    
    @State private var mealViewmodel =  MealViewModel()
    @State private var goalViewModel = NutriGoalViewModel()
    @Environment(AppState.self) private var appState
    
    @State private var isShowingAddActivity = false
    @State private var isShowingAddMeal = false
   
    var stats: [Stat] {
        [
            Stat(type: "Calories", value: Double(mealViewmodel.calculTotal(type: "Calories")) ?? 0, target: goalViewModel.nutriGoal?.caloriesTarget ?? 2000, color: .violet),
            Stat(type: "Protéines", value: Double(mealViewmodel.calculTotal(type: "Protéines")) ?? 0, target: goalViewModel.nutriGoal?.proteinsTarget ?? 100, color: .rose),
            Stat(type: "Lipides", value: Double(mealViewmodel.calculTotal(type: "Lipides")) ?? 0, target: goalViewModel.nutriGoal?.fatsTarget ?? 70, color: .vert),
            Stat(type: "Glucides", value: Double(mealViewmodel.calculTotal(type: "Glucides")) ?? 0, target: goalViewModel.nutriGoal?.carbsTarget ?? 250, color: .bleu)
        ]
    }

    var body: some View {
        NavigationStack {
            
            //DATE DU JOUR
            Text(Date.now, format: Date.FormatStyle()
                .day()
                .month(.wide)
                .year()
                .locale(Locale(identifier: "fr_FR"))
            )
                .font(.custom("Parkinsans-SemiBold", size: 24))
                .padding(.bottom, 25)
                .padding(.top, 20)
            VStack(alignment: .leading) {
             
                Text("Progression")
                    .font(.custom("Parkinsans-Medium", size: 20))
                
                VStack(spacing: 20) {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.gris)
                        HStack(spacing: 15) {
                            ForEach(stats) { stat in
                                StatsView(stat: stat)
                            }
                        }
                    }
                    .cornerRadius(15)
                    .frame(height: 190)
                }
                
                
                Text("Tâches")
                    .font(.custom("Parkinsans-Medium", size: 20))
                
                HStack {
                    // AJOUTER ACTIVITÉ
                    Button {
                        isShowingAddActivity.toggle()
                    } label: {
                        ZStack {
                            Rectangle()
                                .foregroundColor(.bleuC)
                                .cornerRadius(15)
                            VStack(alignment: .center, spacing: 10) {
                                Image("activity")
                                    .resizable()
                                    .frame(width: 70, height: 70)
                                Text("Ajouter une activité")
                                    .font(.custom("Parkinsans-SemiBold", size: 16))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.black)
                                    .padding(10)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 185)
                    .sheet(isPresented: $isShowingAddActivity) {
                        AddActivityView()
                            .presentationDetents([.height(530)])
                            .presentationDragIndicator(.visible)
                    }
                    
                    // AJOUTER REPAS - MAINTENANT EN MODALE
                    Button {
                        isShowingAddMeal.toggle()
                    } label: {
                        ZStack {
                            Rectangle()
                                .foregroundColor(.vertC)
                                .cornerRadius(15)
                            VStack(alignment: .center, spacing: 10) {
                                Image("dej")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                Text("Ajouter un\nrepas")
                                    .font(.custom("Parkinsans-SemiBold", size: 16))
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.center)
                                    .padding(10)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 185)
                    .fullScreenCover(isPresented: $isShowingAddMeal) {
                        AddMealTypeView(
                            viewModel: mealViewmodel,
                            onMealSaved: {
                                isShowingAddMeal = false
                            }
                        )
                    }
                }
                
                // VOIR HISTORIQUE
                NavigationLink(destination: PickerView()) {
                    ZStack {
                        Rectangle()
                            .frame(maxWidth: .infinity)
                            .frame(height: 170)
                            .cornerRadius(15)
                            .foregroundColor(.violetC)
                        HStack(alignment: .center, spacing: 20) {
                            Image("stats")
                                .resizable()
                                .frame(width: 60, height: 60)
                            Text("Mon historique global")
                                .font(.custom("Parkinsans-SemiBold", size: 16))
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)
                                .padding(10)
                        }
                    }
                }
                
                Spacer()
            }
            .padding(.horizontal, 17)
        }
        .onAppear {
            Task {
                guard let token = appState.token else { return print("Error: No token") }
                await mealViewmodel.getUserMeals(token: token)
                await goalViewModel.getNutriGoal(token: token)
            }
        }
    }
}

#Preview {
    DashboardView()
        .environment(AppState())
}
