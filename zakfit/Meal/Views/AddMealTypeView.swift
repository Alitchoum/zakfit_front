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
    @Bindable var viewModel: MealViewModel
    
    @State private var selectedMealType: MealType? = nil
    @State private var navigateToMealView = false
    
    var onMealSaved: (() -> Void)? = nil
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                
                //CLOSE MODAL
                Button{
                    dismiss()
                }label: {
                    HStack{
                        Spacer()
                        Image("close")
                            .resizable()
                            .frame(width: 35, height: 35)
                    }
                }
                .padding(.top, 10)
                
                Text("Sélectionner un type \nde repas")
                    .font(.custom("Parkinsans-SemiBold", size: 25))
                    .padding(.bottom, 40)
                    .padding(.top, 20)
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
                
                Button {
                    navigateToMealView = true
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
                
                Spacer()
            }
            .padding(.horizontal, 17)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
            .navigationDestination(isPresented: $navigateToMealView) {
                if let mealType = selectedMealType {
                    MealView(
                        viewModel: viewModel,
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

