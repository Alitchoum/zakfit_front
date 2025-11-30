//
//  CreateActivity.swift
//
//
//  Created by alize suchon on 26/11/2025.
//

import SwiftUI

struct AddActivityView : View {
    
    @State var viewModel = ActivityViewModel()
    
    let colorArray: [Color] = [.vert, .bleu, .rose, .violet, .vert, .bleu, .rose, .violet]
    
    var body: some View {
                VStack (spacing: 15){
            Rectangle()
                .foregroundColor(.black)
                .cornerRadius(15)
                .frame(width: 50, height: 6)
                .padding(.bottom, 30)
                .padding(.top, 20)
            
            Text("Ajouter une activité")
                .font(.custom("Parkinsans-SemiBold", size: 25))
                .padding(.bottom, 20)
            
            HStack {
                Text("Type d’activité")
                    .font(.custom("Parkinsans-SemiBold", size: 16))
                    .padding(.horizontal, 17)
                Spacer()
            }
            
            //ajouter cat ici
            ScrollView(.horizontal, showsIndicators: false) {
                HStack{
                    ForEach(viewModel.categories){ category in
                        ZStack{
                            Circle()
                                .frame(width: 60, height: 60)
                                .foregroundColor(.gris)
                                .padding(.leading, 15)
            
                            AsyncImage(url: URL(string: "http://127.0.0.1:8080/activity/\(category.picto)")) { picto in picto
                                    .resizable()
                                    .frame(width: 33, height: 33)
                                    .padding(.leading, 15)
                                    
                            } placeholder: {
                                ProgressView()
                                    .frame(height: 20)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 0)
                    
            HStack {
                Text("Informations générales")
                    .font(.custom("Parkinsans-SemiBold", size: 16))
                Spacer()
            }
            .padding(.horizontal, 17)
                    
            //DURATION
            TextField("Durée", text: .constant(""))
                .padding(.horizontal, 20)
                .frame(height: 50)
                .background(.gris)
                .cornerRadius(15)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .padding(.horizontal, 17)
                    
            //CALORIES BURNED
            TextField("Calorie brûlées", text: .constant(""))
                .padding(.horizontal, 20)
                .frame(height: 50)
                .background(.gris)
                .cornerRadius(15)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .padding(.horizontal, 17)
            
            //BUTTON
            Button{
                //Logique
            }label: {
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
            }
            Spacer()
        }
        .onAppear {
            Task{
                await viewModel.fetchCategories()
            }
        }
    }
}

#Preview {
    AddActivityView()
}
