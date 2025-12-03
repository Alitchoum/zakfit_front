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
    @State var physicalViewModel = PhysicalGoalViewModel()
    @State var nutriViewModel = NutriGoalViewModel()
    
    var userInfos: [InfosItem] {
        let user = appState.user
        return [
            InfosItem(color: .bleu, picto: "ruler", title: "Taille", value: user?.size != nil ? "\(user!.size!) cm" : "Vide"),
            InfosItem(color: .vert, picto: "scales", title: "Poids", value: user?.weight != nil ? "\(user!.weight!) kg" : "Vide"),
            InfosItem(color: .violet, picto: "cake", title: "Âge", value: user?.age != nil ? "\(user!.age!) ans" : "Vide")
        ]
    }
    
    var body: some View {
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
        .padding(.horizontal, 17)
    
        //SCROLL VIEW
        ScrollView(.vertical, showsIndicators: false){
            VStack (alignment: .leading, spacing: 20){
                Text("Infos personnelles")
                    .font(.custom("Parkinsans-Medium", size:20))
                    .padding(.top, 20)
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
                
                //BLOC DYNAMIQUE NUTRI GOAL
                if nutriViewModel.nutriGoal != nil {
                    NutriGoalView(viewModel: nutriViewModel)
                } else{
                    
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
                        AddNutriGoalView(
                                       viewModel: nutriViewModel,
                                       onGoalAdded: {
                                           Task {
                                               guard let token = appState.token else { return }
                                               await nutriViewModel.getNutriGoal(token: token)
                                           }
                                       }
                                   )
                            .presentationDetents([.height(640)])
                            .presentationDragIndicator(.visible)
                    }
                }
                
                Text("Activités physiques")
                    .font(.custom("Parkinsans-Medium", size:20))
                    .foregroundColor(.black)
                
                //BLOC DYNAMIQUE PHYSICAL GOAL
                if physicalViewModel.physicalGoal != nil {
                    PhysicalGoalView(viewModel: physicalViewModel)
                } else{
                    
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
                                Text("Ajouter objectif physique")
                                    .font(.custom("Parkinsans-Medium", size:16))
                                    .foregroundColor(.black)
                            }
                        }
                    }
                    .sheet(isPresented: $isShowingAddPhysical){
                        AddPhysicalGoalView(
                                       viewModel: physicalViewModel,
                                       onGoalAdded: {
                                           Task {
                                               guard let token = appState.token else { return }
                                               await physicalViewModel.getPhysicalGoal(token: token)
                                           }
                                       }
                                   )
                            .presentationDetents([.height(560)])
                            .presentationDragIndicator(.visible)
                    }
                }
                
                Spacer()
            }
            .padding(.horizontal, 17)
            .onAppear {
                guard let token = appState.token else {
                    return print("Error : no token")
                }
                Task {
                    await nutriViewModel.getNutriGoal(token: token)
                    await physicalViewModel.getPhysicalGoal(token: token)
                }
            }
        }
    }
}

#Preview {
    ProfilView()
        .environment(AppState())
}
