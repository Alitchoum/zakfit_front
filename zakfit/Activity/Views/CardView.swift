//
//  CardView.swift
//  zakfit
//
//  Created by alize suchon on 30/11/2025.
//

import SwiftUI

struct CardView: View {
    
    var body: some View {
        VStack{
            ZStack{
                Rectangle()
                    .foregroundColor(.bleuC)
                    .frame(height: 95)
                    .cornerRadius(15)
                HStack (spacing: 30){
                    ZStack{
                        Circle()
                            .frame(width: 64, height: 64)
                            .foregroundColor(.bleu)
                        Image("sport")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                    VStack (alignment: .leading){
                        Text("Cyclisme")
                            .font(.custom("Parkinsans-SemiBold", size: 16 ))
                       
                        HStack(spacing: 15){
                            
                            //Calories brûlées
                            HStack(spacing: 5){
                                Image("eclair-fill")
                                    .resizable()
                                    .frame(width: 13, height: 18)
                                Text("Kcls")
                            }
                            
                            //Durée
                            HStack(spacing: 5){
                                Image("clock-fill")
                                    .resizable()
                                    .frame(width: 18, height: 18)
                                Text("min")
                            }
                            
                            //Date
                            HStack(spacing: 5){
                                Image("calendar-fill")
                                    .resizable()
                                    .frame(width: 18, height: 19)
                                Text("12/03/2025")
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, 17)
    }
}

#Preview {
    CardView()
}
