//
//  MealView.swift
//  zakfit
//
//  Created by alize suchon on 24/11/2025.
//

import SwiftUI

struct MealView: View {
    
    @Environment(AppState.self) private var appState
    @State var viewModel = MealViewModel()
    let textArray = arrayInfos
    var mealType: MealType? = nil
    
    @State private var createdMeal: MealResponseDTO? = nil  // Meal créé côté backend
    
    var body: some View {
        NavigationStack{
            VStack( spacing: 30){
                
                //TYPE REPAS
                if let meal = mealType {
                    Text(meal.name)
                        .font(.custom("Parkinsans-SemiBold", size: 25))
                        .padding(.top, 20)
                } else {
                    Text("Vide")
                        .font(.custom("Parkinsans-SemiBold", size: 25))
                        .padding(.top, 20)
                }
                
                //PICTO PHOTO
                ZStack(alignment: .bottomTrailing){
                    Rectangle()
                        .ignoresSafeArea()
                        .foregroundColor(.gray)
                        .frame(height: 285)
                    VStack{
                        Image("photo")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .padding(20)
                    }
                }
                VStack(alignment: .leading, spacing: 20){
                    HStack{
                        ForEach(textArray) { item in
                            ZStack{
                                Rectangle()
                                    .frame(height: 90)
                                    .cornerRadius(15)
                                    .foregroundColor(item.color)
                                VStack(spacing: 5){
                                    Text("\(item.value)g")
                                        .font(Font.custom("Parkinsans-SemiBold", size: 20))
                                    Text(item.type)
                                        .font(.system(size: 14))
                                }
                            }
                        }
                    }
                    
                    //ADD FOODS
                    HStack{
                        Text("Produits alimentaires")
                            .font(.custom("Parkinsans-Medium", size: 20))
                        Spacer()
                        
                        if let mealID = createdMeal?.id {  // Passer l'ID du meal créé à AddFoodInMeal
                            NavigationLink(destination: AddFoodInMeal(mealID: mealID)){
                                Image("plus")
                                
                            }
                        }
                    }
                    
                    //LISTES DES ALIMENTS AJOUTÉS ICI
                    
                }
                .padding(.horizontal, 17)
                Spacer()
            }
            .onAppear {
                Task {
                    guard let token = appState.token,
                          let type = mealType?.name
                    else { return print("Error missing data") }
                    
                    // Crée le meal et récupère la réponse
                    if let meal = await viewModel.sendCreateMeal(token: token, type: type) {
                        self.createdMeal = meal
                    }
                }
            }
        }
    }
}

#Preview {
    MealView()
}
