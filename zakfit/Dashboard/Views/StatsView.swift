//
//  ProgressView.swift
//  zakfit
//
//  Created by alize suchon on 03/12/2025.
//

import SwiftUI

struct StatsView: View {
    
    let stat: Stat
    
    var body: some View {
        VStack{
            ZStack{
                Circle()
                    .stroke(style: StrokeStyle(lineWidth: 8))
                    .foregroundColor(stat.color.opacity(0.5))
                Circle()
                    .trim(from: 0, to: min(stat.value / stat.target, 1.0))
                    .stroke(stat.color, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                VStack{
                    Text("\(Int(stat.value))")
                        .font(.custom("Parkinsans-SemiBold", size: 16))
                        .foregroundColor(.black)
                    Text("/\(Int(stat.target))g")
                        .font(Font.system(size: 10))
                        .foregroundColor(.gray)
                }
            }
            .frame(width: 72, height: 72)
            Text(stat.type)
                .font(.custom("Parkinsans-Medium", size: 14))
                .font(.system( size: 14))
                .foregroundColor(.black)
                .padding(.top, 10)
        }        
    }
}

#Preview {
    StatsView(stat: Stat(
        type : "Calories",
        value : 3000,
        target: 4000,
        color: .violet
    ))
}
