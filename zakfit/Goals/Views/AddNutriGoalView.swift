//
//  ModaleNutriGoalView.swift
//  zakfit
//
//  Created by alize suchon on 29/11/2025.
//

import SwiftUI

struct AddNutriGoalView: View {
    
    @Environment(AppState.self) private var appState
    @Environment(\.dismiss) private var dismiss
    
    @State var viewModel: NutriGoalViewModel
    @State private var showPersoGoal = false
    @State private var showAlert = false
    
    let Array = infosArray
    var onGoalAdded: (() -> Void)? = nil
        
    var body: some View {
            VStack {
           
                Text("Objectif nutritionnel")
                    .font(.custom("Parkinsans-SemiBold", size: 25))
                    .padding(.bottom, 20)
                    .padding(.top, 50)
                
                Text("Choisissez comment définir votre objectif nutritionnel.")
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.bottom, 30)
                
                ForEach(Array) { info in
                    ZStack {
                        Rectangle()
                            .foregroundColor(info.color)
                            .frame(height: 215)
                            .cornerRadius(15)
                        
                        VStack(spacing: 15) {
                            Text(info.title)
                                .font(.custom("Parkinsans-SemiBold", size: 18))
                                .foregroundColor(.black)
                            
                            Text(info.description)
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)
                                .padding(.bottom, 20)
                            
                            Button {
                                if info.buttonText == "Lancer" {
                                    // CALCUL AUTO
                                    Task {
                                        guard let token = appState.token else {
                                            return print("Error : No token")
                                        }
                                        await viewModel.fetchAutoNutriGoal(token: token)
                                        onGoalAdded?()
                                        showAlert = true
                                    }
                                    //PERSONNALISER GOAL
                                } else {
                                    showPersoGoal.toggle()
                                }
                            } label: {
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(.black)
                                        .cornerRadius(15)
                                    Text(info.buttonText)
                                        .font(.custom("Parkinsans-Medium", size: 16))
                                        .foregroundColor(.white)
                                }
                                .frame(height: 50)
                            }
                            .alert("Objectif ajouté avec succés ​🥑​", isPresented: $showAlert) {
                                Button("OK", role: .cancel) {
                                    dismiss()
                                }
                            }
                        }
                        .padding(.horizontal, 25)
                    }
                    .padding(.vertical, 3)
                }
                
                Spacer()
            }
            .padding(.horizontal, 17)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
            .sheet(isPresented: $showPersoGoal ) {
                PersoNutiGoal(
                    viewModel: viewModel,
                    onSave: {
                        showPersoGoal = false
                        dismiss()
                    }
                )
                .presentationDragIndicator(.visible)
            }
    }
}


#Preview {
    AddNutriGoalView(viewModel: NutriGoalViewModel())
        .environment(AppState())
}
