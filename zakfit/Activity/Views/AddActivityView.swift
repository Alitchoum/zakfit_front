//
//  CreateActivity.swift
//
//
//  Created by alize suchon on 26/11/2025.
//

import SwiftUI

struct AddActivityView : View {
    
    @Environment(AppState.self) private var appState
    @Environment(\.dismiss) private var dismiss
    
    @State var viewModel = ActivityViewModel()
    @State private var selectedCategoryID: UUID? = nil
    @State private var durationText = ""
    @State private var caloriesText = ""
    @State private var showAlert = false
        
    var body: some View {
        VStack (spacing: 15){
            Text("Ajouter une activité")
                .font(.custom("Parkinsans-SemiBold", size: 25))
                .padding(.bottom, 20)
                .padding(.top, 30)
            
            HStack {
                Text("Type d’activité")
                    .font(.custom("Parkinsans-SemiBold", size: 16))
                    .padding(.horizontal, 17)
                Spacer()
            }
            
            //CATEGORIES
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 9){
                    Rectangle()
                        .frame(width: 5, height: 60)
                        .foregroundColor(.white)
                    ForEach(viewModel.categories){ category in
                     
                        Button{
                            selectedCategoryID = category.id
                        }label: {
                            ZStack{
                                
                                Circle()
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(Color("\(category.color)"))
                                    .overlay(
                                        Circle()
                                            .stroke(selectedCategoryID == category.id ? Color.black : Color.clear, lineWidth: 1)
                                    )
                                    .padding(1)
                                
                                AsyncImage(url: URL(string: "http://127.0.0.1:8080/activity/\(category.picto)")) { picto in picto
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
                Text("Informations générales")
                    .font(.custom("Parkinsans-SemiBold", size: 16))
                Spacer()
            }
            .padding(.horizontal, 17)
            
            //DURATION
            TextField("Durée", text: $durationText)
                .padding(.horizontal, 20)
                .frame(height: 50)
                .background(.gris)
                .cornerRadius(15)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .padding(.horizontal, 17)
                .keyboardType(.numberPad)
            
            //CALORIES BURNED
            TextField("Calorie brûlées", text: $caloriesText)
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
                guard let duration = Int(durationText),
                      let caloriesBurned = Int(caloriesText),
                      let selectedCategoryID,
                      let token = appState.token
                else {
                    return print("Error missing datas")
                }
                //send data table activities
                Task{
                    await viewModel.sendActivityDTO(token: token, duration: duration, caloriesBurned: caloriesBurned, categoryID: selectedCategoryID)
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
                .padding(.top, 20)
            }
            .alert("Activité ajoutée avec succès!", isPresented: $showAlert) {
                Button("OK", role: .cancel) {
                    dismiss()
                }
                Spacer()
            }
            .onAppear {
                Task{
                    await viewModel.fetchCategories()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
    }
}

#Preview {
    AddActivityView()
        .environment(AppState())
}
