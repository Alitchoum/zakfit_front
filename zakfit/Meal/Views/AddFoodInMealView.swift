//
//  AddFoodInMeal.swift
//  zakfit
//
//  Created by alize suchon on 01/12/2025.
//

import SwiftUI

struct AddFoodInMeal: View {
    
    @State var viewModel = MealViewModel()
    @State var selectedCategoryID: UUID? = nil
    @State var search: String = ""
    @State var showAddUserFood: Bool = false
    let colors = colorArray
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15){
            
            HStack{
                Text("Ajouter aliments")
                    .font(.custom("Parkinsans-SemiBold", size: 24))
                Spacer()
                
                //LINK ADD PRODUCT
                Button {
                    showAddUserFood.toggle()
                }label: {
                    Image("croix")
                        .frame(width: 24, height: 22)
                }
                .sheet(isPresented: $showAddUserFood){
                    AddFoodUserView()
                        .presentationDetents([.height(700)])
                }
            }
            
            //SEARCH //A METTRE EN PLACE
            HStack{
                TextField("Rechercher un aliment", text: $search)
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
            }
            
            //CATEGORIES FOOD
            Text("Catégories aliments")
                .font(.custom("Parkinsans-SemiBold", size: 16))
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
                        }label: {
                            ZStack{
                                
                                Circle()
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(circleColor)
                                    .overlay(
                                        Circle()
                                            .stroke(selectedCategoryID == category.id ? Color.black : Color.clear, lineWidth: 1)
                                    )
                                    .padding(1)
                                
                                AsyncImage(url: URL(string: "http://127.0.0.1:8080/foodCategory/\(category.picto)")) { picto in picto
                                        .resizable()
                                        .frame(width: 33, height: 33)
                                } placeholder: {
                                    ProgressView()
                                        .frame(height: 20)
                                }
                            }
                        }
                        .onTapGesture {
                            selectedCategoryID = category.id
                        }
                        
                        //AJOUTER ICI LISTE ALIMENT D'APRÈS FILTRES / SEARCH
                    }
                }
            }
        }
        .padding(.horizontal, 17)
        .onAppear {
            Task{
                await viewModel.fetchFoodCategories()
            }
        }
    }
}

#Preview {
    AddFoodInMeal()
}
