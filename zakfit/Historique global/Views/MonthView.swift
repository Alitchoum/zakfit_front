//
//  MonthView.swift
//  zakfit
//
//  Created by alize suchon on 30/11/2025.
//


import SwiftUI

struct MonthView: View {
    
    @Environment(AppState.self) var appState
    
    private let columns = [
        GridItem(.flexible(), spacing: 14),
        GridItem(.flexible(), spacing: 14)
    ]
    
    var currentMonth: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.dateFormat = "LLLL yyyy"
        return formatter.string(from: Date()).capitalized
    }
        
    let array = arrayMonth
    
    var body: some View {
        VStack(spacing: 20) {
            
            HStack(spacing: 15) {
                Image("left")
                    .resizable()
                    .frame(width: 7, height: 13)
                
                Text(currentMonth)
                    .font(.custom("Parkinsans-Medium", size: 20))
                
                Image("right")
                    .resizable()
                    .frame(width: 7, height: 13)
            }
            .padding(.vertical, 30)
            
            LazyVGrid(columns: columns, spacing: 40) {
                ForEach(array) { item in
                    ZStack(alignment: .leading) {
                        
                        Rectangle()
                            .fill(item.color.opacity(0.5))
                            .cornerRadius(15)
                        
                        // Forme imbriquée
                        Image("shape")
                            .resizable()
                            .scaledToFill()
                            .offset(x: 70, y: -50)
                            .frame(height: 230)
                            .clipped()
                       
                        VStack(alignment: .leading) {
                            // Picto
                            ZStack {
                                Rectangle()
                                    .frame(width: 70, height: 70)
                                    .foregroundColor(item.color)
                                    .cornerRadius(15)
                                
                                Image(item.picto)
                                    .resizable()
                                    .frame(width: 35, height: 35)
                            }
                            Spacer()
                            //value /type
                            VStack(alignment: .leading, spacing: 2) {
                                Text("\(item.value)")
                                    .font(.custom("Parkinsans-SemiBold", size: 30))
                                Text(item.type)
                                    .font(.system(size: 16))
                                    .fixedSize(horizontal: false, vertical: true)

                            }
                            .padding(.bottom, 8)
                        }
                        .padding(20)
                    }
                    .frame(height: 200)
                }
            }
            
            Spacer()
        }
        .padding(.horizontal, 17)
    }
}
#Preview {
    MonthView()
        .environment(AppState())
}
