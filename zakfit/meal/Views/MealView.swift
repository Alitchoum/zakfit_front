//
//  MealView.swift
//  zakfit
//
//  Created by alize suchon on 24/11/2025.
//

import SwiftUI

struct MealView: View {
    
    var body: some View {
        VStack{
            ZStack{
                Rectangle()
                    .ignoresSafeArea()
                    .foregroundColor(.gray)
                    .frame(height: 295)
            }
            VStack(alignment: .leading, spacing: 10){
                Text("Repas")
                    .font(.custom("Parkinsans-SemiBold", size: 24))
                
                
//                    ForEach() { bloc in
//                        HStack{
//                        
//                    }
//                }
                Text("Produits alimentaires")
                    .font(.custom("Parkinsans-Medium", size: 20))
            }
            .padding(.horizontal, 17)
        }
    }
}

#Preview {
    MealView()
}
