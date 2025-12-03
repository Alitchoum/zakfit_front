//
//  NutriGoalView.swift
//  zakfit
//
//  Created by alize suchon on 03/12/2025.
//

import SwiftUI

struct NutriGoalView: View {
    
    @Environment(AppState.self) private var appState
    @State var viewModel : NutriGoalViewModel
    
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
                        Text("g / \(String(format: "%.0f", Double(viewModel.nutriGoal?.caloriesTarget ?? 0)))g")
                            .font(.system(size: 16))
                    }
                    // PROGRESS BAR
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(.white)
                            .frame(height: 20)
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(.violet)
                            .frame(width: 100, height: 20)
                    }
                }
                
                //BLOC PROTEINES
                if viewModel.nutriGoal?.proteinsTarget != nil {
                    VStack(spacing: 20){
                        HStack {
                            Text("Calories / jour")
                                .font(.system(size: 16))
                            Spacer()
                            Text("g / \(String(format: "%.0f", Double(viewModel.nutriGoal?.proteinsTarget ?? 0)))g")
                                .font(.system(size: 16))
                        }
                        // PROGRESS BAR
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(.white)
                                .frame(height: 20)
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(.rose)
                                .frame(width: 100, height: 20)
                        }
                    }
                }
                //BLOC LIPIDES
                if viewModel.nutriGoal?.fatsTarget != nil {
                    VStack(spacing: 20){
                        HStack {
                            Text("Lipide / jour")
                                .font(.system(size: 16))
                            Spacer()
                            Text("g / \(String(format: "%.0f", Double(viewModel.nutriGoal?.fatsTarget ?? 0)))g")
                                .font(.system(size: 16))
                        }
                        // PROGRESS BAR
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(.white)
                                .frame(height: 20)
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(.vert)
                                .frame(width: 100, height: 20)
                        }
                    }
                }
                
                //BLOC GLUCIDES
                if viewModel.nutriGoal?.carbsTarget != nil {
                    VStack(spacing: 20){
                        HStack {
                            Text("Glucides / jour")
                                .font(.system(size: 16))
                            Spacer()
                            Text("g / \(String(format: "%.0f", Double(viewModel.nutriGoal?.carbsTarget ?? 0)))g")
                                .font(.system(size: 16))
                        }
                        // PROGRESS BAR
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(.white)
                                .frame(height: 20)
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(.bleu)
                                .frame(width: 100, height: 20)
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
    NutriGoalView(viewModel: NutriGoalViewModel())
        .environment(AppState())
}
