//
//  NutrimentCardView.swift
//  zakfit
//
//  Created by alize suchon on 02/12/2025.
//

import SwiftUI

struct NutrimentCardView: View {
        
    var body: some View {
        VStack{
            ZStack{
                Rectangle()
                    .cornerRadius(15)
                    .frame(width: 50, height: 50)
                    .foregroundColor(.white)
                Image("feu")
                    .resizable()
                    .frame(width: 27, height: 27)
            }
            Text("Calories")
                .font(.system(size: 16))
                .foregroundColor(.black)
            Text("100 g")
                .font(.custom("Parkinsans-SemiBold", size: 20))
                .foregroundColor(.black)
        }
    }
}

#Preview {
    NutrimentCardView()
}
