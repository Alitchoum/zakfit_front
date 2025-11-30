//
//  DashboardView.swift
//  zakfit
//
//  Created by alize suchon on 24/11/2025.
//

import SwiftUI

struct DashboardView: View {
    
    @State private var isShowingAddActivity = false
    @State private var isShowingAddLMeal = false
    
    var body: some View {
        NavigationStack{
            
            VStack(alignment: .leading){
                Text("Dashboard")
                    .font(.custom("Parkinsans-SemiBold", size: 24))
                    .padding(.bottom, 40)
                
                Text("Progression")
                    .font(.custom("Parkinsans-Medium", size: 20))
                
                Rectangle()
                    .frame(maxWidth: .infinity)
                    .frame(height: 170)
                    .cornerRadius(15)
                    .foregroundColor(.gris)
                
                Text("Mes tâches")
                    .font(.custom("Parkinsans-Medium", size: 20))
                
                HStack{
                    //AJOUTER ACTIVITÉ
                    Button{
                        isShowingAddActivity.toggle()
                    } label: {
                        
                        ZStack{
                            Rectangle()
                                .foregroundColor(.bleuC)
                                .cornerRadius(15)
                            VStack(alignment: .center, spacing: 10){
                                Image("activity")
                                    .resizable()
                                    .frame(width: 70, height: 70)
                                Text("Ajouter une activité")
                                    .font(.custom("Parkinsans-SemiBold", size: 16))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.black)
                                    .padding(10)
                            }
                        }
                    }
                    .sheet(isPresented: $isShowingAddActivity){
                        AddActivityView()
                            .presentationDetents([.height(530)])
                            .background(.white)
                    }
                    
                    //AJOUTER REPAS
                    Button{
                        isShowingAddLMeal.toggle()
                    }label: {
                    ZStack{
                        Rectangle()
                            .foregroundColor(.vertC)
                            .cornerRadius(15)
                        VStack(alignment: .center, spacing: 10){
                            Image("dej")
                                .resizable()
                                .frame(width: 60, height: 60)
                            Text("Ajouter un\nrepas")
                                .font(.custom("Parkinsans-SemiBold", size: 16))
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)
                                .padding(10)
                        }
                    }
                }
                    .frame(maxWidth: .infinity)
                    .frame(height: 185)
                    .sheet(isPresented: $isShowingAddLMeal){
                        AddMealView()
                            .presentationDetents([.height(500)])
                            .background(.white)
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 185)
                
                //VOIR HISTORIQUE
                NavigationLink(destination: PickerView()){
                    ZStack{
                        Rectangle()
                            .frame(maxWidth: .infinity)
                            .frame(height: 170)
                            .cornerRadius(15)
                            .foregroundColor(.violetC)
                        HStack(alignment: .center, spacing: 20){
                            Image("stats")
                                .resizable()
                                .frame(width: 60, height: 60)
                            Text("Mon historique global")
                                .font(.custom("Parkinsans-SemiBold", size: 16))
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)
                                .padding(10)
                        }
                    }
                }
                
                Spacer()
            }
            .padding(.horizontal, 17)
        }
    }
}

#Preview {
    DashboardView()
}
