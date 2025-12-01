//
//  ModaleSportGoalView.swift
//  zakfit
//
//  Created by alize suchon on 30/11/2025.
//

import SwiftUI

struct AddSportGoalView: View {
        
    var body: some View {

            VStack (spacing: 15){
                Rectangle()
                    .foregroundColor(.black)
                    .cornerRadius(15)
                    .frame(width: 50, height: 6)
                    .padding(.bottom, 30)
                    .padding(.top, 20)
                
                //TITLE
                Text("Objectif physique")
                    .font(.custom("Parkinsans-SemiBold", size: 25))
                    .padding(.bottom, 10)
                
                //IMAGE
                Image("activity")
                    .resizable()
                    .frame(width: 79, height: 79)
                    .padding(.bottom, 10)
                
                //DESCRIPTION
                Text("is a long established fact that a reader will be distracted.")
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.bottom, 10)
                
                //CATEGORY
                HStack{
                    Text("Catégorie *:")
                        .font(.custom("Parkinsans-SemiBold", size: 16))
                    Spacer()
                }
                               
                //FREQUENCY
                TextField("Fréquence / semaine", text: .constant(""))
                    .padding(.horizontal, 20)
                    .frame(height: 50)
                    .background(.gris)
                    .cornerRadius(15)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                
                //DURATION
                TextField("Durée / séance", text: .constant(""))
                    .padding(.horizontal, 20)
                    .frame(height: 50)
                    .background(.gris)
                    .cornerRadius(15)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                
                //CALORIES BURNED
                ZStack {
                    TextField("Calories brûlées", text: .constant(""))
                        .padding(.horizontal, 20)
                        .frame(height: 50)
                        .background(.gris)
                        .cornerRadius(15)
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                    
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
                }
                Spacer()
            }
            .padding(.horizontal, 17)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
    }
}

#Preview {
    AddSportGoalView()
}
