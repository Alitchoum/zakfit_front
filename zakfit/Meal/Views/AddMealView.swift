//
//  AddMealTypeView.swift
//  zakfit
//
//  Created by alize suchon on 28/11/2025.
//

import SwiftUI
struct AddMealView: View {

    let array = MealTypeArray
    
    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Text("Ajouter un repas")
                    .font(.custom("Parkinsans-SemiBold", size: 25))
                    .padding(.bottom, 50)
                
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(array) { type in
                        
                        NavigationLink(destination: MealView(selectedMealType: type)) {
                            ZStack {
                                Rectangle()
                                    .foregroundColor(type.color)
                                    .cornerRadius(15)
                                    .frame(height: 200)
                                
                                VStack(spacing: 30) {
                                    Image(type.picto)
                                        .resizable()
                                        .frame(width: 64, height: 64)
                                    
                                    Text(type.name)
                                        .font(.custom("Parkinsans-Medium", size: 18))
                                        .foregroundColor(.black)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 18)
                //Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
           .background(.white)
        }
    }
}

#Preview {
    AddMealView()
}

