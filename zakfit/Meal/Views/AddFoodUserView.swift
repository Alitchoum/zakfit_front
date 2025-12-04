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
    
    @State var viewModel =  MealViewModel()
    @State private var selectedCategoryID: UUID? = nil
    
    @State private var nameText = ""
    @State private var caloriesText = ""
    @State private var carbsText = ""
    @State private var fatsText = ""
    @State private var proteinsText = ""
    
    @State private var messageError = ""
    @State private var showAlert = false
    
    let colors = colorArray
    
    var body: some View {
        VStack (spacing: 15){
            Text("Aliment personnalisé")
                .font(.custom("Parkinsans-SemiBold", size: 25))
                .padding(.bottom, 20)
                .padding(.top, 50)
            
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
                .keyboardType(.numberPad)
                .padding(.horizontal, 17)
            
            //PROTEINS
            TextField("Proteines / 100g", text: $proteinsText)
                .padding(.horizontal, 20)
                .frame(height: 50)
                .background(.gris)
                .cornerRadius(15)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .keyboardType(.numberPad)
                .padding(.horizontal, 17)
            
            //ALERTE MESSAGE
            Text(messageError)
                .foregroundColor(.red)
                .font(.system(size: 16))
            
            //BUTTON
            Button {
                if let error = validateFields() {
                    messageError = error
                    return
                }
                
                let calories100g = Double(caloriesText)!
                let carbs100g = Double(carbsText)!
                let fats100g = Double(fatsText)!
                let proteins100g = Double(proteinsText)!
                
                Task {
                    await viewModel.sendUserFood(
                        token: appState.token!,
                        name: nameText,
                        calories100g: calories100g,
                        carbs100g: carbs100g,
                        fats100g: fats100g,
                        proteins100g: proteins100g,
                        foodCategoryID: selectedCategoryID!
                    )
                    showAlert = true
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
                .alert("Aliment ajouté avec succès!", isPresented: $showAlert) {
                    Button("OK", role: .cancel) {
                        dismiss()
                    }
                }
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
    
    //MARK: - FONCTION
    func validateFields() -> String? {
        
        //VERIF CAT SELECTIONNÉE
        guard let selectedCategoryID else { return "Veuillez sélectionner une catégorie" }
        
        //VERIF NAME
        if nameText.isEmpty {
            return "Veuillez entrer le nom de l’aliment"
        }
        
        //VERIF TEXFIELDS
        guard Double(caloriesText) != nil else { return "Veuillez entrer les calories" }
        guard Double(carbsText) != nil else { return "Veuillez entrer les glucides" }
        guard Double(fatsText) != nil else { return "Veuillez entrer les lipides" }
        guard Double(proteinsText) != nil else { return "Veuillez entrer les protéines" }
        
        return nil
    }
}

#Preview {
    AddFoodUserView()
        .environment(AppState())
}
