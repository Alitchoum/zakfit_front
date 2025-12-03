//
//  MyDishsView.swift
//  zakfit
//
//  Created by alize suchon on 27/11/2025.
//

import SwiftUI

struct MyMealsView: View {
    
    @Environment(AppState.self) private var appState
    @State private var viewModel = MealViewModel()
    
    var body: some View {
        NavigationStack{
            VStack{
                Text("Mes repas")
                    .font(.custom("Parkinsans-SemiBold", size: 24))
                    .padding(.bottom, 40)
                VStack(alignment: .leading, spacing: 15){
                    
                    Text("Total jour")
                        .font(.custom("Parkinsans-Medium", size: 20))
                    
                    Text("Repas")
                        .font(.custom("Parkinsans-Medium", size: 20))
                    
                    if viewModel.meals.isEmpty {
                        NavigationLink(destination: AddMealTypeView()){
                            ZStack{
                                Rectangle()
                                    .frame(width: 368, height: 112)
                                    .foregroundColor(.gris)
                                    .cornerRadius(15)
                                HStack(spacing:35){
                                    Image("plus")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                    Text("Ajouter votre premier repas")
                                        .font(.custom("Parkinsans-Medium", size:16))
                                        .foregroundColor(.black)
                                }
                            }
                        }
                    } else {
                        //LISTE REPAS
                    }
                    
                    
                }
            }
            .padding(.horizontal, 17)
        }
    }
}

#Preview {
    MyMealsView()
        .environment(AppState())
}
