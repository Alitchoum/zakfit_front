//
//  ModaleSportGoalView.swift
//  zakfit
//
//  Created by alize suchon on 30/11/2025.
//

import SwiftUI

struct AddPhysicalGoalView: View {
        
    @Environment(AppState.self) private var appState
    @Environment(\.dismiss) private var dismiss
    @State var viewModel = PhysicalGoalViewModel()
    
    @State private var fequencyText = ""
    @State private var durationText = ""
    @State private var caloriesText = ""
    @State private var showAlert = false
    
    var onGoalAdded: (() -> Void)? = nil
    
    var body: some View {

            VStack (spacing: 15){
                //TITLE
                Text("Objectif physique")
                    .font(.custom("Parkinsans-SemiBold", size: 25))
                    .padding(.bottom, 10)
                    .padding(.top, 50)
                //IMAGE
                Image("activity")
                    .resizable()
                    .frame(width: 79, height: 79)
                    .padding(.bottom, 15)
                
                //DESCRIPTION
                Text("Restez motivée grâce à un suivi simple et clair de vos objectifs sportifs.")
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.bottom, 20)
                
                //CATEGORY
                HStack{
                    Text("Catégorie *:")
                        .font(.custom("Parkinsans-SemiBold", size: 16))
                    Spacer()
                }
                               
                //FREQUENCY
                TextField("Fréquence / semaine", text: $fequencyText)
                    .padding(.horizontal, 20)
                    .frame(height: 50)
                    .background(.gris)
                    .cornerRadius(15)
                    .keyboardType(.numberPad)
                    .disableAutocorrection(true)
                
                //DURATION
                TextField("Durée / séance", text: $durationText)
                    .padding(.horizontal, 20)
                    .frame(height: 50)
                    .background(.gris)
                    .cornerRadius(15)
                    .disableAutocorrection(true)
                    .keyboardType(.numberPad)
                
                //CALORIES BURNED
                ZStack {
                    TextField("Calories brûlées", text: $caloriesText)
                        .padding(.horizontal, 20)
                        .frame(height: 50)
                        .background(.gris)
                        .cornerRadius(15)
                        .disableAutocorrection(true)
                        .keyboardType(.numberPad)
                    
                    //BUTTON CALCUL AUTO
                    HStack{
                        Spacer()
                        Button {
                            //logique calcul
                        }label: {
                            ZStack{
                                Rectangle()
                                    .foregroundColor(.bleu)
                                    .frame(width: 179, height: 50)
                                    .cornerRadius(15)
                                Text("Calcul auto")
                                    .font(.custom("Parkinsans-SemiBold", size: 16))
                                    .foregroundColor(.black)
                            }
                        }
                    }
                }
                
                //BUTTON TO VALIDATE
                Button{
                        guard let token = appState.token
                    else {
                            return print("error : token invalid")
                        }
                    let frequency = Int(fequencyText)
                       let duration = Int(durationText)
                       let caloriesBurned = Double(caloriesText)
                    
                    Task {
                        await viewModel.fetchPhysicalGoal(token: token, duration: duration, frequency: frequency, caloriesBurned: caloriesBurned)
                        onGoalAdded?()
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
                .padding(.top, 10)
                .alert("Objectif physique ajouté avec succés 💪", isPresented: $showAlert) {
                    Button("OK", role: .cancel){
                        dismiss()
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 17)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
    }
}

#Preview {
    AddPhysicalGoalView()
        .environment(AppState())
}
