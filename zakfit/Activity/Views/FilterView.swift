//
//  FilterView.swift
//  zakfit
//
//  Created by alize suchon on 30/11/2025.
//

import SwiftUI

struct FilterView: View {
    
    @State private var isSelectedCat = false
    
    let SportArray = ["Cyclisme", "Course à pied", "Musculation", "Yoga", "Natation", "Sport de combat", "Sport de raquette", "Sport de ballon"]
    
    var body: some View {
        Text("Filtres")
            .font(.custom("Parkinsans-SemiBold", size: 24))
            .padding(.bottom, 40)
        VStack(alignment: .leading){
            Text("Catégories")
                .font(.custom("Parkinsans-Medium", size: 20))
            ZStack{
                Rectangle()
                    .frame(maxWidth: .infinity)
                    .cornerRadius(15)
                    .foregroundColor(.gris)
                VStack (alignment: .leading, spacing: 15){
                    ForEach(SportArray, id: \.self) { item in
                        HStack{
                            Text(item)
                                .font(.system(size:16))
                                .padding(.leading, 15)
                            Spacer()
                            
                            Button{
                                isSelectedCat.toggle()
                            }label: {
                                Image(isSelectedCat ? "ratio1" : "ratio2")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .padding(.trailing, 15)
                            }
                        }
                    }
                }
            }
    
            Text("Durée")
                .font(.custom("Parkinsans-Medium", size: 20))
            
            Text("Sélectionner une période")
                .font(.custom("Parkinsans-Medium", size: 20))
            
        }
        .padding(.horizontal, 17)
    }
}

#Preview {
    FilterView()
}
