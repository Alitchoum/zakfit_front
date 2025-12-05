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
    
    var mealInfos: [MyMealsModel] {
        [
            .init(type: "Calories", back: .violetC, color: .violet),
            .init(type: "Protéines", back: .roseC , color: .rose),
            .init(type: "Lipides", back: .vertC, color: .vert),
            .init(type: "Glucides", back: .bleuC, color: .bleu)
        ]
    }
    
    var body: some View {
        NavigationStack{
            VStack{
                Text("Mes repas")
                    .font(.custom("Parkinsans-SemiBold", size: 24))
                    .padding(.bottom, 20)
                    .padding(.top, 30)
                VStack(alignment: .leading, spacing: 15){
                    
                    Text("Total jour")
                        .font(.custom("Parkinsans-Medium", size: 20))
                   
                    HStack{
                    ForEach(mealInfos) { info in
                            ZStack{
                                Rectangle()
                                    .frame(height: 100)
                                    .foregroundColor(info.color)
                                    .cornerRadius(15)
                                VStack{
                                    Text(viewModel.calculTotal(type : info.type))
                                        .font(Font.custom("Parkinsans-SemiBold", size: 20))
                                        .foregroundColor(.black)
                                    Text(info.type)
                                        .font(.system(size: 16))
                                        .foregroundColor(.black)
                                }
                            }
                        }
                    }
                    
                    Text("Repas")
                        .font(.custom("Parkinsans-Medium", size: 20))
                    
                    ScrollView(.vertical, showsIndicators: false){
                        if viewModel.meals.isEmpty {
                            NavigationLink(destination: AddMealTypeView(viewModel: viewModel)){
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
                            VStack{
                                ForEach(viewModel.meals){ meal in
                                    NavigationLink(destination: MealDetailView(viewModel: viewModel, mealID: meal.id)){
                                        MealCardView(meal: meal)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 17)
            .onAppear {
                Task {
                    guard let token = appState.token else
                    { return print("Error: No Token")}
                    await viewModel.getUserMeals(token: token)
                }
            }
        }
    }
}

#Preview {
    MyMealsView()
        .environment(AppState())
}
