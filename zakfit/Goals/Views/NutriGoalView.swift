//
//  NutriGoalView.swift
//  zakfit
//
//  Created by alize suchon on 03/12/2025.
//

import SwiftUI

struct NutriGoalView: View {
    
    @Environment(AppState.self) private var appState
    @State var nutriViewModel : NutriGoalViewModel
    @State var mealViewModel : MealViewModel

    let maxLargeur: CGFloat = 300
    
    //CALORIES
    var currentCalories: Double {Double(mealViewModel.calculTotal(type: "Calories")) ?? 0}
    var caloriesTarget: Double {nutriViewModel.nutriGoal?.caloriesTarget ?? 0}
    
   //PROTEINS
    var currentProteins: Double { Double(mealViewModel.calculTotal(type: "Protéines")) ?? 0}
    var proteinsTarget: Double {nutriViewModel.nutriGoal?.proteinsTarget ?? 0}
    
    //FATS
    var currentFats: Double {Double(mealViewModel.calculTotal(type: "Lipides")) ?? 0}
     var fatsTarget: Double { nutriViewModel.nutriGoal?.fatsTarget ?? 0}
    
    //CARBS
    var currentCarbs: Double { Double(mealViewModel.calculTotal(type: "Glucides")) ?? 0 }
     var carbsTarget: Double { nutriViewModel.nutriGoal?.carbsTarget ?? 0 }
    
    var body: some View {
        
        VStack {
            VStack(alignment: .leading, spacing: 20) {
                Text("Objectif nutritionnel")
                    .font(.custom("Parkinsans-SemiBold", size: 16))
                
                //BLOC CALORIES
                    VStack(spacing: 20){
                        HStack {
                            Text("Calories / jour")
                                .font(.system(size: 16))
                            Spacer()
                            Text(" \(String(format: "%.0f",currentCalories))g / \(String(format: "%.0f",caloriesTarget))g")
                                .font(.system(size: 16))
                        }
                        // PROGRESS BAR
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(.white)
                                .frame(height: 20)
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(.violet)
                                .frame(width: nutriViewModel.progressBar(current: currentCalories, target: caloriesTarget , maxWidth: maxLargeur), height: 20)
                        }
                    }
                
                //BLOC PROTEINES
                if nutriViewModel.nutriGoal?.proteinsTarget != nil {
                    VStack(spacing: 20){
                        HStack {
                            Text("Proteines / jour")
                                .font(.system(size: 16))
                            Spacer()
                            Text("\(String(format: "%.0f", currentProteins))g / \(String(format: "%.0f", proteinsTarget))g")
                                .font(.system(size: 16))
                        }
                        // PROGRESS BAR
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(.white)
                                .frame(height: 20)
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(.rose)
                                .frame(width: nutriViewModel.progressBar(current: currentProteins, target: proteinsTarget, maxWidth: maxLargeur), height: 20)
                        }
                    }
                }
                //BLOC LIPIDES
                if nutriViewModel.nutriGoal?.fatsTarget != nil {
                    VStack(spacing: 20){
                        HStack {
                            Text("Lipides / jour")
                                .font(.system(size: 16))
                            Spacer()
                            Text("\(String(format: "%.0f", currentFats))g / \(String(format: "%.0f", fatsTarget))g")
                                .font(.system(size: 16))
                        }
                        // PROGRESS BAR
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(.white)
                                .frame(height: 20)
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(.vert)
                                .frame(width: nutriViewModel.progressBar(current: currentFats, target: fatsTarget, maxWidth: maxLargeur), height: 20)
                        }
                    }
                }
                
                //BLOC GLUCIDES
                if nutriViewModel.nutriGoal?.carbsTarget != nil {
                    VStack(spacing: 20){
                        HStack {
                            Text("Glucides / jour")
                                .font(.system(size: 16))
                            Spacer()
                            Text("\(String(format: "%.0f", currentCarbs))g / \(String(format: "%.0f", carbsTarget))g")
                                .font(.system(size: 16))
                        }
                        // PROGRESS BAR
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(.white)
                                .frame(height: 20)
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(.bleu)
                                .frame(width: nutriViewModel.progressBar(current: currentCarbs, target: carbsTarget, maxWidth: maxLargeur), height: 20)
                        }
                    }
                }
    
                //BUTTON
                Button{
                    //logique
                }label: {
                    ZStack{
                        Rectangle()
                            .foregroundColor(.black)
                            .cornerRadius(15)
                            .frame(height: 50)
                        Text("Modifier/Supprimer")
                            .font(.custom("Parkinsans-Medium", size: 16))
                            .foregroundColor(.white)
                    }
                    .padding(.top, 10)
                }
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(.gris)
            )
        }
    }
}

#Preview {
    NutriGoalView(nutriViewModel: NutriGoalViewModel(), mealViewModel: MealViewModel())
        .environment(AppState())
}
