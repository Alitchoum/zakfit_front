//
//  AddMealTypeView.swift
//  zakfit
//
//  Created by alize suchon on 28/11/2025.
//

import SwiftUI

struct AddMealTypeView: View {
    
    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    let array = MealTypeArray
    
    @Environment(AppState.self) private var appState
    @Environment(\.dismiss) private var dismiss
    @State var viewModel : MealViewModel
    
    @State private var selectedMealType: MealType? = nil
    @State private var createdMealID: UUID? = nil
    @State private var navigateToMealView = false
    
    var onMealSaved: (() -> Void)? = nil
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
  
                Text("Sélectionner un type \nde repas")
                    .font(.custom("Parkinsans-SemiBold", size: 25))
                    .padding(.bottom, 40)
                    .multilineTextAlignment(.center)
                
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(array) { type in
                        Button {
                            selectedMealType = type
                        } label: {
                            ZStack {
                                Rectangle()
                                    .foregroundColor(type.color)
                                    .cornerRadius(15)
                                    .frame(height: 200)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(selectedMealType == type ? Color.black : Color.clear, lineWidth: 2)
                                    )
                                
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
                
                //BUTTON
                Button {
                    Task {
                        guard let token = appState.token,
                              let type = selectedMealType?.name
                        else {
                            return print("error: Datas invalid")
                        }
                        
                        // ADD API
                        if let meal = await viewModel.sendCreateMeal(token: token, type: type) {
                            createdMealID = meal.id
                            navigateToMealView = true
                        }
                    }
                } label: {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.black)
                            .cornerRadius(15)
                        Text("Valider")
                            .font(.custom("Parkinsans-Medium", size: 16))
                            .foregroundColor(.white)
                    }
                    .frame(height: 50)
                    .padding(.top, 15)
                }
                .disabled(selectedMealType == nil)
            }
            .padding(.horizontal, 17)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
            .navigationDestination(isPresented: $navigateToMealView) {
                            if let mealID = createdMealID, let mealType = selectedMealType {
                                MealView(
                                    viewModel: viewModel,
                                    mealID: mealID,
                                    mealType: mealType,
                                    onSave: {
                                        dismiss()
                                        onMealSaved?()
                                    }
                                )
                            }
                        }
                    }
                }
            }

#Preview {
    AddMealTypeView(viewModel: MealViewModel())
        .environment(AppState())
}

