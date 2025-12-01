//
//  ProfilView.swift
//  zakfit
//
//  Created by alize suchon on 24/11/2025.
//

import SwiftUI

struct ProfilView: View {
    
    @Environment(AppState.self) var appState
    @State private var isShowingAddNutri = false
    @State private var isShowingAddPhysical = false
    
    var userInfos: [InfosItem] {
        let user = appState.user
        return [
            InfosItem(color: .bleu, picto: "ruler", title: "Taille", value: user?.size != nil ? "\(user!.size!) cm" : "Vide"),
            InfosItem(color: .vert, picto: "scales", title: "Poids", value: user?.weight != nil ? "\(user!.weight!) kg" : "Vide"),
            InfosItem(color: .violet, picto: "cake", title: "Âge", value: user?.age != nil ? "\(user!.age!) ans" : "Vide")
        ]
    }
    
    var body: some View {
        VStack (alignment: .leading, spacing: 20){
            HStack{
                Text("Profil")
                    .font(.custom("Parkinsans-SemiBold", size:24))
                
                Spacer()
                
                NavigationLink {
                    SettingsView()
                } label: {
                    Image("nut")
                }
            }
            .padding(.bottom, 40)
            Text("Infos personnelles")
                .font(.custom("Parkinsans-Medium", size:20))
            
            //BLOC INFOS PERSO
            HStack(spacing: 8){
                ForEach(userInfos) { info in
                    ZStack{
                        Rectangle()
                            .foregroundColor(info.color)
                            .cornerRadius(15)
                        VStack{
                            ZStack{
                                Rectangle()
                                    .frame(width: 45, height: 45)
                                    .foregroundColor(.white.opacity(0.5))
                                    .cornerRadius(8)
                                Image(info.picto)
                                    .resizable()
                                    .frame(width: 30, height: 30)
                            }
                            .padding(.bottom,8)
                            Text(info.title)
                                .font(.custom("Parkinsans-SemiBold", size:16))
                            Text(info.value)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 130)
                }
            }
            
            Text("Nutrition")
                .font(.custom("Parkinsans-Medium", size:20))
            
            //BLOC NUTRI GOAL
            Button {
                isShowingAddNutri.toggle()
            } label: {
                ZStack{
                    Rectangle()
                        .frame(width: 368, height: 112)
                        .foregroundColor(.gris)
                        .cornerRadius(15)
                    HStack(spacing:35){
                        Image("plus")
                            .resizable()
                            .frame(width: 30, height: 30)
                        Text("Ajouter objectif nutritionnel")
                            .font(.custom("Parkinsans-Medium", size:16))
                            .foregroundColor(.black)
                    }
                    
                }
            }
            .sheet(isPresented: $isShowingAddNutri){
                AddNutriGoalView()
                    .presentationDetents([.height(670)])
            }
            
            Text("Activités physiques")
                .font(.custom("Parkinsans-Medium", size:20))
                .foregroundColor(.black)
            
            //AJOUTER PHYSICAL GOAL
            Button {
                isShowingAddPhysical.toggle()
            }label: {
                ZStack{
                    Rectangle()
                        .frame(width: 368, height: 112)
                        .foregroundColor(.gris)
                        .cornerRadius(15)
                    HStack(spacing:35){
                        Image("plus")
                            .resizable()
                            .frame(width: 30, height: 30)
                        Text("Ajouter objectif pysique")
                            .font(.custom("Parkinsans-Medium", size:16))
                            .foregroundColor(.black)
                    }
                    
                }
            }
            .sheet(isPresented: $isShowingAddPhysical){
                AddSportGoalView()
                    .presentationDetents([.height(550)])
            }
            Spacer()
        }
        .padding(17)
    }
}

#Preview {
    ProfilView()
        .environment(AppState())
}
