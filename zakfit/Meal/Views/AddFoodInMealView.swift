//
//  AddFoodInMeal.swift
//  zakfit
//
//  Created by alize suchon on 01/12/2025.
//

import SwiftUI

struct AddFoodInMeal: View {
    
    @Environment(AppState.self) private var appState
    @Environment(\.dismiss) private var dismiss
    @Bindable var viewModel: MealViewModel
    
    @State var search: String = ""
    @State var messageError: String = ""
    @State var selectedCategoryID: UUID? = nil
    @State var showAddUserFood = false
    @State private var selectedFood: FoodResponse? = nil
    
    let colors = colorArray
    
    var filteredFoods: [FoodResponse] {
        var result = viewModel.foods
        
        if let categoryID = selectedCategoryID {
            result = result.filter { $0.foodCategoryID == categoryID }
        }
        
        if !search.isEmpty {
            result = result.filter { $0.name.lowercased().contains(search.lowercased()) }
        }
        return result
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Ajouter aliments")
                    .font(.custom("Parkinsans-SemiBold", size: 24))
                Spacer()
                
                Button {
                    showAddUserFood.toggle()
                } label: {
                    Image("croix")
                        .frame(width: 24, height: 22)
                }
            }
            .padding(.horizontal, 17)
            .padding(.bottom, 20)
            .padding(.top, 40)
            
            // SEARCH
            HStack {
                TextField("Rechercher un aliment", text: $search)
                    .padding(.horizontal, 20)
                    .frame(height: 50)
                    .background(.gris)
                    .cornerRadius(30)
                    .textInputAutocapitalization(.never)
                
                ZStack {
                    Circle()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.black)
                    
                    Image("magnifying-glass")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.white)
                }
            }
            .padding(.horizontal, 17)
            .padding(.bottom, 20)
            
            // CATEGORIES
            HStack {
                Text("Catégories aliments")
                    .font(.custom("Parkinsans-SemiBold", size: 16))
                    .padding(.bottom, 15)
                Spacer()
            }
            .padding(.horizontal, 17)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 9) {
                    Rectangle()
                        .frame(width: 5, height: 60)
                        .foregroundColor(.white)
                    ForEach(viewModel.foodCategories.indices, id: \.self) { index in
                        let category = viewModel.foodCategories[index]
                        let circleColor = colors[index % colors.count]
                        
                        Button {
                            selectedCategoryID = category.id
                        } label: {
                            ZStack {
                                Circle()
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(circleColor)
                                    .overlay(
                                        Circle()
                                            .stroke(selectedCategoryID == category.id ? Color.black : Color.clear, lineWidth: 1)
                                    )
                                    .padding(1)
                                AsyncImage(url: URL(string: "http://127.0.0.1:8080/foodCategory/\(category.picto)")) { picto in
                                    picto
                                        .resizable()
                                        .frame(width: 33, height: 33)
                                } placeholder: {
                                    ProgressView()
                                        .frame(height: 20)
                                }
                            }
                        }
                        .padding(.bottom, 10)
                    }
                }
            }
            
            Text(messageError)
                .foregroundColor(.gray)
                .font(.system(size: 16, weight: .bold))
                .padding(.top, 50)
            
            // FOODS LIST
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(filteredFoods) { food in
                    Button {
                        selectedFood = food
                    } label: {
                        ZStack {
                            Rectangle()
                                .frame(height: 80)
                                .cornerRadius(15)
                                .foregroundColor(.gris)
                            
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(food.name)
                                        .font(.custom("Parkinsans-SemiBold", size: 16))
                                        .foregroundColor(.black)
                                    Text("Portion 100g")
                                        .font(.system(size: 16))
                                        .foregroundColor(.gray)
                                }
                                .padding(.leading, 20)
                                
                                Spacer()
                                
                                VStack(alignment: .center) {
                                    Image("fire-fill")
                                        .resizable()
                                        .frame(width: 17, height: 21)
                                    Text("\(Int(food.calories100g)) cals")
                                        .font(.system(size: 14))
                                }
                                .padding(.trailing, 20)
                            }
                        }
                    }
                    .padding(.horizontal, 17)
                }
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
        .sheet(isPresented: $showAddUserFood) {
            AddFoodUserView()
                .presentationDetents([.height(800)])
                .presentationDragIndicator(.visible)
        }
        .sheet(item: $selectedFood) { food in
            FoodDetailView(viewModel: viewModel, food: food)
                .presentationDetents([.height(630)])
                .presentationDragIndicator(.visible)
        }
        .task {
            if viewModel.foodCategories.isEmpty {
                await viewModel.fetchFoodCategories()
            }
            if viewModel.foods.isEmpty, let token = appState.token {
                await viewModel.fetchAllFoods(token: token)
            }
        }
        .onChange(of: search) { _, newValue in
            if search.isEmpty {
                messageError = ""
            } else if filteredFoods.isEmpty {
                messageError = "Aucun résultat"
            } else {
                messageError = ""
            }
        }
    }
}

#Preview {
    AddFoodInMeal(viewModel: MealViewModel())
        .environment(AppState())
}
