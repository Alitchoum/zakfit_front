//
//  ModaleNutriGoalView.swift
//  zakfit
//
//  Created by alize suchon on 29/11/2025.
//

import SwiftUI

struct AddNutriGoalView: View {
    
    let Array = infosArray
    
    var body: some View {

            VStack {
                Rectangle()
                    .foregroundColor(.black)
                    .cornerRadius(15)
                    .frame(width: 50, height: 6)
                    .padding(.bottom, 30)
                    .padding(.top, 20)
                
                Text("Objectif nutritionnel")
                    .font(.custom("Parkinsans-SemiBold", size: 25))
                    .padding(.bottom, 20)
                
                Text("is a long established fact that a reader will be distracted.")
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.bottom, 30)
                
                ForEach(Array) { info in
                    ZStack{
                        Rectangle()
                            .foregroundColor(info.color)
                            .frame(height: 215)
                            .cornerRadius(15)
                        
                        VStack(spacing: 15){
                            //TITLE
                            Text(info.title)
                                .font(.custom("Parkinsans-SemiBold", size: 18))
                                .foregroundColor(.black)
                            
                            //DESCRIPTION
                            Text(info.description)
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)
                                .padding(.bottom, 20)
                            
                            //BUTTON
                            Button{
                                //Logique
                            }label: {
                                ZStack{
                                Rectangle()
                                    .foregroundColor(.black)
                                    .cornerRadius(15)
                                Text(info.buttonText)
                                    .font(.custom("Parkinsans-Medium", size: 16))
                                    .foregroundColor(.white)
                            }
                            .frame(height: 50)
                            }
                        }
                        .padding(.horizontal, 25)
                    }
                }
                .padding(.vertical, 3)
                
                Spacer()
            }
            .padding(.horizontal, 17)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
    }
}

#Preview {
    AddNutriGoalView()
}
