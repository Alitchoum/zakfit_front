//
//  PersoNutiGoal.swift
//  zakfit
//
//  Created by alize suchon on 30/11/2025.
//

import SwiftUI

struct PersoNutiGoal: View {
    
    @Environment(AppState.self) private var appState
    @Environment(\.dismiss) private var dismiss
    @State var viewModel : NutriGoalViewModel
    
    @State private var caloriesText = ""
    @State private var proteinsText = ""
    @State private var fatsText = ""
    @State private var carbsText = ""
    @State private var showAlert = false
    
    var onSave: (() -> Void)? = nil
    
    var body: some View {
        
        VStack (spacing:15){
            Text("Objectif personnalisé")
                .font(.custom("Parkinsans-SemiBold", size: 25))
                .multilineTextAlignment(.center)
                .padding(.bottom, 20)
                .padding(.top, 60)
            
            //IMAGE
            Image("nutri")
                .resizable()
                .frame(width: 79, height: 79)
                .padding(.bottom, 40)
            
            //CALORIES
            HStack{
                Text("Objectif visé:")
                    .font(.custom("Parkinsans-SemiBold", size: 16))
                Spacer()
            }
            TextField("Calories / jour", text: $caloriesText)
                .padding(.horizontal, 20)
                .frame(height: 50)
                .background(.gris)
                .cornerRadius(15)
                .disableAutocorrection(true)
                .keyboardType(.numberPad)
            
            //MACROS
            HStack{
                Text("Définir mes macros* :")
                    .font(.custom("Parkinsans-SemiBold", size: 16))
                Spacer()
            }
            //PROTEINS
            TextField("Proteines / jour", text: $proteinsText)
                .padding(.horizontal, 20)
                .frame(height: 50)
                .background(.gris)
                .cornerRadius(15)
                .disableAutocorrection(true)
                .keyboardType(.numberPad)
            
            //FATS
            TextField("Lipides / jour", text: $fatsText)
                .padding(.horizontal, 20)
                .frame(height: 50)
                .background(.gris)
                .cornerRadius(15)
                .disableAutocorrection(true)
                .keyboardType(.numberPad)
            
            //CARBS
            TextField("Glucides / jour", text: $carbsText)
                .padding(.horizontal, 20)
                .frame(height: 50)
                .background(.gris)
                .cornerRadius(15)
                .disableAutocorrection(true)
                .keyboardType(.numberPad)
            
            //BUTTON TO VALIDATE
            Button{
                guard let token = appState.token,
                      let calories = Double(caloriesText)
                else {
                    return print("Error: data not valid")
                }
                let proteins = Double(proteinsText) ?? nil
                let fats = Double(fatsText) ?? nil
                let carbs = Double(carbsText) ?? nil
                Task {
                    await viewModel.fetchNutriGoal(token: token, caloriesTarget: calories, proteinsTarget: proteins, carbsTarget: carbs, fatsTarget: fats, isAuto: false)
                    showAlert = true
                }
            } label: {
                ZStack(alignment: .center) {
                    Rectangle()
                        .foregroundColor(.black)
                        .cornerRadius(15)
                    Text("Valider")
                        .font(.custom("Parkinsans-Medium", size: 16))
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 50)
            }
            .alert("Objectif ajouté avec succés ​🥑​​", isPresented: $showAlert) {
                Button("OK", role: .cancel) {
                    onSave?()
                }
            }
            
            Spacer()
        }
        .padding(.horizontal, 17)
        .presentationDetents([.height(730)])
        .background(.white)
    }
}


#Preview {
    PersoNutiGoal(viewModel: NutriGoalViewModel())
        .environment(AppState())
}
