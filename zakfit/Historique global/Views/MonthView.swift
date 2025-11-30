//
//  MonthView.swift
//  zakfit
//
//  Created by alize suchon on 30/11/2025.
//


import SwiftUI

struct MonthView: View {
    
    @Environment(AppState.self) var appState
    
    @State private var columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    let array = arrayMonth

       var body: some View {
           VStack {
               Text("Récap du mois ")
                   .font(.custom("Parkinsans-Medium", size: 25))
                   .padding(.bottom, 20)

               LazyVGrid(columns: columns, spacing: 10) {
                   ForEach(array) { item in
                       ZStack{
                           Rectangle()
                               .frame(height: 200)
                               .foregroundColor(item.color)
                               .cornerRadius(15)
                           VStack{
                               //PICTO
                               ZStack{
                                   Circle()
                                       .frame(width: 65, height: 65)
                                       .foregroundColor(.white.opacity(0.5))
                                      
                                   Image(item.picto)
                                       .resizable()
                                       .frame(width: 40, height: 40)
                                   
                               }
                               Text("\(item.value)")
                                   .font(.custom("Parkinsans-SemiBold", size: 25))
                                   .padding(.top, 20)
                               Text(item.type)
                                   .font(.system(size: 15))
                           }
                       }
                       .frame(maxWidth: .infinity)
                   }
               }
           }

        .padding(.horizontal, 17)
    }
}

#Preview {
    MonthView()
        .environment(AppState())
}
