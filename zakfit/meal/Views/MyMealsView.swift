//
//  MyDishsView.swift
//  zakfit
//
//  Created by alize suchon on 27/11/2025.
//

import SwiftUI

struct MyMealsView: View {
    var body: some View {
        VStack{
            Text("Mes repas")
                .font(.custom("Parkinsans-SemiBold", size: 24))
                .padding(.bottom, 40)
            Text("Calcul total jour")
                .font(.custom("Parkinsans-Medium", size: 20))
            Text("Repas")
                .font(.custom("Parkinsans-Medium", size: 20))
            
            
        }
        .padding(.horizontal, 17)
        
    }
}

#Preview {
    MyMealsView()
}
