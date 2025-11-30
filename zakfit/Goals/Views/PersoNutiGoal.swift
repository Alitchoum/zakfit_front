//
//  PersoNutiGoal.swift
//  zakfit
//
//  Created by alize suchon on 30/11/2025.
//

import SwiftUI

struct PersoNutiGoal: View {
    
    @State private var ShowSheet = false
    
    var body: some View {
        VStack {
            Button(action: {
                ShowSheet.toggle()
            }) {
                Text("PERSO NUTRITION GOAL")
            }
        }
        .sheet(isPresented: $ShowSheet) {
            VStack (spacing:15){
                Rectangle()
                    .foregroundColor(.black)
                    .cornerRadius(15)
                    .frame(width: 50, height: 6)
                    .padding(.bottom, 30)
                    .padding(.top, 20)
                
                Text("Objectif personnalisé")
                    .font(.custom("Parkinsans-SemiBold", size: 25))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 20)
                
                //IMAGE
                Image("nutri")
                    .resizable()
                    .frame(width: 79, height: 79)
                    .padding(.bottom, 10)
                
                //DESCRIPTION
                Text("is a long established fact that a reader will be distracted.")
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.bottom, 10)
                
                //CALORIES
                HStack{
                    Text("Objectif visé:")
                        .font(.custom("Parkinsans-SemiBold", size: 16))
                    Spacer()
                }
                TextField("Calories / jour", text: .constant(""))
                    .padding(.horizontal, 20)
                    .frame(height: 50)
                    .background(.gris)
                    .cornerRadius(15)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                
                //MACROS
                HStack{
                    Text("Définir mes macros* :")
                        .font(.custom("Parkinsans-SemiBold", size: 16))
                    Spacer()
                }
                //PROTEINS
                TextField("Proteines / jour", text: .constant(""))
                    .padding(.horizontal, 20)
                    .frame(height: 50)
                    .background(.gris)
                    .cornerRadius(15)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                
                //FATS
                TextField("Lipides / jour", text: .constant(""))
                    .padding(.horizontal, 20)
                    .frame(height: 50)
                    .background(.gris)
                    .cornerRadius(15)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                
                //CARBS
                TextField("Carbs / jour", text: .constant(""))
                    .padding(.horizontal, 20)
                    .frame(height: 50)
                    .background(.gris)
                    .cornerRadius(15)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                
                //BUTTON TO VALIDATE
                Button{
                    //LOGIQUE
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
                
                Spacer()
            }
            .padding(.horizontal, 17)
            .presentationDetents([.height(730)])
            .background(.white)
        }
    }
}

#Preview {
    PersoNutiGoal()
}
