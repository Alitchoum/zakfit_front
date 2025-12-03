//
//  AddFoodInMeal.swift
//  zakfit
//
//  Created by alize suchon on 01/12/2025.
//

import SwiftUI

struct AddFoodInMeal: View
{
    @Environment(AppState.self) private var appState
    @State var viewModel = MealViewModel()
    @State var selectedCategoryID: UUID? = nil
    @State var search: String = ""
    @State var showAddUserFood = false
    @State var showDetailFood = false
    
    @State private var selectedFood: FoodResponse? = nil
    
    let colors = colorArray
    var mealID: UUID
    
    var body: some View {
        VStack{
            HStack{
                Text("Ajouter aliments")
                    .font(.custom("Parkinsans-SemiBold", size: 24))
                Spacer()
                
                //LINK ADD PRODUCT
                Button {
                    showAddUserFood.toggle()
                }label:
                { Image("croix")
                    .frame(width: 24, height: 22) }
                .sheet(isPresented: $showAddUserFood){
                    AddFoodUserView()
                        .presentationDetents([.height(800)])
                        .presentationDragIndicator(.visible)
                }
            }
            .padding(.horizontal, 17)
            .padding(.bottom, 20)
            .padding(.top, 40)
            
            //SEARCH -> A METTRE EN PLACE
            HStack{
                TextField("Rechercher un aliment",text: $search)
                    .padding(.horizontal, 20)
                    .frame(height: 50)
                    .background(.gris)
                    .cornerRadius(30)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                
                ZStack{
                    Circle()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.black)
                    
                    Image("magnifying-glass")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.white)
                }
            } .padding(.horizontal, 17)
                .padding(.bottom, 20)
            
            //CATEGORIES FOOD
            HStack{
                Text("Catégories aliments")
                    .font(.custom("Parkinsans-SemiBold", size: 16))
                    .padding(.bottom, 15)
                Spacer()
            }
            .padding(.horizontal, 17)
            
            //CATEGORIES FOOD
            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing: 9){
                    Rectangle()
                        .frame(width: 5, height: 60)
                        .foregroundColor(.white)
                    ForEach(viewModel.foodCategories.indices, id: \.self){ index in
                        let category = viewModel.foodCategories[index]
                        let circleColor = colors[index % colors.count]
                        
                        Button{
                            selectedCategoryID = category.id
                        } label: {
                            ZStack{
                                Circle()
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(circleColor)
                                    .overlay(
                                        Circle()
                                            .stroke(selectedCategoryID == category.id ? Color.black : Color.clear, lineWidth: 1) )
                                    .padding(1)
                                AsyncImage(url: URL(string: "http://127.0.0.1:8080/foodCategory/\(category.picto)")) { picto in picto
                                        .resizable()
                                        .frame(width: 33, height: 33)
                                }
                                placeholder: {
                                    ProgressView()
                                        .frame(height: 20)
                                }
                            }
                        }
                        .padding(.bottom, 10)
                        .onTapGesture {
                            selectedCategoryID = category.id
                        }
                    }
                }
            }
            
            //FOODS LIST
            ScrollView(.vertical, showsIndicators: false){
                ForEach(viewModel.foods){ food in
                    //BUTTON DETAIL FOOD
                    Button{
                        selectedFood = food
                        showDetailFood.toggle()
                    }label: {
                        ZStack{
                            Rectangle()
                                .frame(height: 80)
                                .cornerRadius(15)
                                .foregroundColor(.gris)
                            
                            HStack{
                                VStack(alignment: .leading){
                                    Text(food.name)
                                        .font(.custom("Parkinsans-SemiBold", size: 16))
                                        .foregroundColor(.black)
                                    Text("Portion 100g")
                                        .font(.system(size: 16))
                                        .foregroundColor(.gray)
                                }
                                .padding(.leading, 20)
                                
                                Spacer()
                                
                                VStack(alignment: .center){
                                    Image("fire-fill")
                                        .resizable()
                                        .frame(width: 17, height: 21)
                                    Text("\(Int(food.calories100g)) cals")
                                }
                                .padding(.trailing, 20) }
                        }
                    }
                    .padding(.horizontal, 17)
                    
                    //DETAIL FOOD MODAL
                    .sheet(item: $selectedFood) { item in
                        FoodDetailView(viewModel: viewModel, mealID: mealID, food: item)
                            .presentationDetents([.height(650)])
                            .presentationDragIndicator(.visible)

                    }
                }
            }
            
            Spacer()
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
        .onAppear {
            Task{ await viewModel.fetchFoodCategories()
                //charge cat foods
                if let token = appState.token{
                    await viewModel.fetchAllFoods(token: token)
                    //charge all foods
                } else {
                    print("Error: Token not found")
                }
            }
        }
        .onChange(of: search) { _, newValue in
            viewModel.searchText = newValue
        }
        .onChange(of: selectedCategoryID) { _, newValue in
            viewModel.selectedCategoryID = newValue
        }
    }
}

#Preview {
    AddFoodInMeal(viewModel: MealViewModel(), mealID: UUID())
        .environment(AppState())
}
