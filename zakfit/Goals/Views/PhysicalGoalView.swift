//
//  PhysicalGoalView.swift
//  zakfit
//
//  Created by alize suchon on 03/12/2025.
//

import SwiftUI

struct PhysicalGoalView: View {
  
        @Environment(AppState.self) private var appState
        @State var viewModel : PhysicalGoalViewModel
        
        var body: some View {
            
            VStack {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Objectif physique")
                        .font(.custom("Parkinsans-SemiBold", size: 16))
                    
                    //BLOC FREQUENCY
                    VStack(spacing: 20){
                        HStack {
                            Text("Fréquence/ semaine")
                                .font(.system(size: 16))
                            Spacer()
                            Text("0 / \(String(format: "%.0f", Double(viewModel.physicalGoal?.frequency ?? 0)))")
                                .font(.system(size: 16))
                        }
                        // PROGRESS BAR
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(.white)
                                .frame(height: 20)
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(.jaune)
                                .frame(width: 100, height: 20)
                        }
                    }
                    
                    //BLOC DURATION
                    if viewModel.physicalGoal?.duration != nil {
                        VStack(spacing: 20){
                            HStack {
                                Text("Durée / séance")
                                    .font(.system(size: 16))
                                Spacer()
                                Text("0 / \(String(format: "%.0f", Double(viewModel.physicalGoal?.duration ?? 0)))min")
                                    .font(.system(size: 16))
                            }
                            // PROGRESS BAR
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundColor(.white)
                                    .frame(height: 20)
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundColor(.jaune)
                                    .frame(width: 100, height: 20)
                            }
                        }
                    }
                    
                    //BLOC CALORIES BRULEES
                    if viewModel.physicalGoal?.caloriesBurned != nil {
                        VStack(spacing: 20){
                            HStack {
                                Text("Calories / jour")
                                    .font(.system(size: 16))
                                Spacer()
                                Text("g / \(String(format: "%.0f", Double(viewModel.physicalGoal?.caloriesBurned ?? 0)))g")
                                    .font(.system(size: 16))
                            }
                            // PROGRESS BAR
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundColor(.white)
                                    .frame(height: 20)
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundColor(.jaune)
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
    PhysicalGoalView(viewModel: PhysicalGoalViewModel())
        .environment(AppState())
}
