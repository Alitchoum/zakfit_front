//
//  AddFoodUserView.swift
//  zakfit
//
//  Created by alize suchon on 01/12/2025.
//

import SwiftUI

struct AddFoodUserView : View {
    
    @Environment(AppState.self) private var appState
    @Environment(\.dismiss) private var dismiss
    
    @State var viewModel = MealViewModel()
    @State private var selectedCategoryID: UUID? = nil
    
    @State private var nameText = ""
    @State private var caloriesText = ""
    @State private var carbsText = ""
    @State private var fatsText = ""
    @State private var proteinsText = ""
    
    @State private var showAlert = false
    
    let colors = colorArray
    
    var body: some View {
        VStack (spacing: 15){
            Rectangle()
                .foregroundColor(.black)
                .cornerRadius(15)
                .frame(width: 50, height: 6)
                .padding(.bottom, 30)
                .padding(.top, 20)
            
            Text("Ajouter une produit")
                .font(.custom("Parkinsans-SemiBold", size: 25))
                .padding(.bottom, 20)
            
            HStack {
                Text("Catégories aliments")
                    .font(.custom("Parkinsans-SemiBold", size: 16))
                    .padding(.horizontal, 17)
                Spacer()
            }
            
            //CATEGORIES FOOD
            ScrollView(.horizontal, showsIndicators: false) {
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
                    }
                }
            }
            .padding(.bottom, 20)
            
            HStack {
                Text("Nom du produit")
                    .font(.custom("Parkinsans-SemiBold", size: 16))
                Spacer()
            }
            .padding(.horizontal, 17)
            
            //NAME
            TextField("Nom du produit", text: $nameText)
                .padding(.horizontal, 20)
                .frame(height: 50)
                .background(.gris)
                .cornerRadius(15)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .padding(.horizontal, 17)
                .keyboardType(.numberPad)
                .padding(.bottom, 15)
            
            //Nutriments
            HStack {
                Text("Nutriments")
                    .font(.custom("Parkinsans-SemiBold", size: 16))
                Spacer()
            }
            .padding(.horizontal, 17)
            
            //CALORIES
            TextField("Calories / 100g", text: $caloriesText)
                .padding(.horizontal, 20)
                .frame(height: 50)
                .background(.gris)
                .cornerRadius(15)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .padding(.horizontal, 17)
                .keyboardType(.numberPad)
            
            //CARBS
            TextField("Glucides / 100g", text: $carbsText)
                .padding(.horizontal, 20)
                .frame(height: 50)
                .background(.gris)
                .cornerRadius(15)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .padding(.horizontal, 17)
                .keyboardType(.numberPad)
            
            //FATS
            TextField("Lipides / 100g", text: $fatsText)
                .padding(.horizontal, 20)
                .frame(height: 50)
                .background(.gris)
                .cornerRadius(15)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .padding(.horizontal, 17)
                .keyboardType(.numberPad)
            
            //PROTEINS
            TextField("Proteines / 100g", text: $proteinsText)
                .padding(.horizontal, 20)
                .frame(height: 50)
                .background(.gris)
                .cornerRadius(15)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .padding(.horizontal, 17)
                .keyboardType(.numberPad)
            
            //BUTTON
            Button{
                guard let token = appState.token,
                      let name = nameText.isEmpty ? nil : nameText,
                      let calories100g = Double(caloriesText),
                      let carbs100g = Double(carbsText),
                      let fats100g = Double(fatsText),
                      let proteins100g = Double(proteinsText),
                      let selectedCategoryID
                else {
                    return print("Error missing datas")
                }
                
                //SEND VERS API
                Task{
                    await viewModel.sendUserFood(token: token, name: name, calories100g: calories100g, carbs100g: carbs100g, fats100g: fats100g, proteins100g: proteins100g, foodCategoryID: selectedCategoryID)
                }
            }label:{
                ZStack{
                    Rectangle()
                        .foregroundColor(.black)
                        .cornerRadius(15)
                    Text("Valider")
                        .font(.custom("Parkinsans-Medium", size: 16))
                        .foregroundColor(.white)
                }
                .frame(height: 50)
                .padding(.horizontal, 17)
                .padding(.top, 12)
            }
            .alert("Aliment ajouté avec succès!", isPresented: $showAlert) {
                Button("OK", role: .cancel) {
                    dismiss()
                }
                Spacer()
            }
            //APPEL API -> AFFICHAGE CATEGORIES
            .onAppear {
                Task{
                    await viewModel.fetchFoodCategories()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
    }
}

#Preview {
    AddFoodUserView()
        .environment(AppState())
}
