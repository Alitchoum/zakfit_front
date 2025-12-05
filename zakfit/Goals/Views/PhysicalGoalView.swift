//
//  PhysicalGoalView.swift
//  zakfit
//
//  Created by alize suchon on 03/12/2025.
//

import SwiftUI

struct PhysicalGoalView: View {
    
    @Environment(AppState.self) private var appState
    @State var sportviewModel: PhysicalGoalViewModel
    @State var activityViewModel: ActivityViewModel
    
    let max: CGFloat = 300
    var currentFrequency =  2
    var durationSession  = 30
    var currentCalories =  350
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 20) {
                Text("Objectif physique")
                    .font(.custom("Parkinsans-SemiBold", size: 16))
                
                // FREQUENCY
                VStack(spacing: 20){
                    HStack {
                        Text("Fréquence / semaine")
                        Spacer()
                        Text("\(currentFrequency) / 5")
                    }
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(.white)
                            .frame(height: 20)
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(.violet)
                            .frame(width: CGFloat(currentFrequency) * 50, height: 20)
                    }
                }
                
                // DURATION
                HStack {
                    Text("Durée / séance")
                    Spacer()
                    Text("\(durationSession) / 45 min")
                    
                }
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(.white)
                        .frame(height: 20)
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(.violet)
                        .frame(width: CGFloat(currentFrequency) * 70, height: 20)
                }
                
                // CALORIES
                HStack {
                    Text("Calories / jour")
                    Spacer()
                    Text("\(currentCalories) / 500")
                    
                }
                
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(.white)
                        .frame(height: 20)
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(.violet)
                        .frame(width: CGFloat(currentFrequency) * 40, height: 20)
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

#Preview {
    PhysicalGoalView(sportviewModel: PhysicalGoalViewModel(), activityViewModel: ActivityViewModel())
        .environment(AppState())
}
