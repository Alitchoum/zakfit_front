//
//  activityView.swift
//  zakfit
//
//  Created by alize suchon on 26/11/2025.
//

import SwiftUI

struct ActivityView: View {
    
    @Environment(AppState.self) var appState
    @State var viewModel = ActivityViewModel()
    @State var showFilter = false
    
    var body: some View {
        NavigationStack{

            VStack{
                Text("Mes activités")
                    .font(.custom("Parkinsans-SemiBold", size: 24))
                    .padding(.bottom, 30)
                    .padding(.top, 30)
                
                HStack{
                    Button{
                        showFilter.toggle()
                    }label: {
                        ZStack(alignment: .center) {
                            Rectangle()
                                .frame(height: 50)
                                .foregroundColor(.black)
                                .cornerRadius(15)
                            HStack{
                                Text("Filtres")
                                    .font(.custom("Parkinsans-Medium", size: 16))
                                    .foregroundColor(.white)
                                    .padding(.leading, 15)
                                Spacer()
                                Image("filtres")
                                    .padding(.trailing, 15)
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                    .fullScreenCover(isPresented: $showFilter) {
                        FilterView(viewModel: viewModel)
                    }
                    
                    //BUTTON SORT
                    ZStack(alignment: .center) {
                        Rectangle()
                            .frame(height: 50)
                            .foregroundColor(.black)
                            .cornerRadius(15)
                        HStack{
                            Text("Trier")
                                .font(.custom("Parkinsans-Medium", size: 16))
                                .foregroundColor(.white)
                                .padding(.leading, 15)
                            Spacer()
                            Image("bottom")
                                .padding(.trailing, 15)
                        }
                    }
                }
                if viewModel.activities.isEmpty {
                    NavigationLink(destination: AddActivityView(viewModel: ActivityViewModel())){
                        ZStack{
                            Rectangle()
                                .frame(width: 368, height: 112)
                                .foregroundColor(.gris)
                                .cornerRadius(15)
                            HStack(spacing:35){
                                Image("plus")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                Text("Ajouter votre première séance")
                                    .font(.custom("Parkinsans-Medium", size:16))
                                    .foregroundColor(.black)
                            }
                        }
                    }
                } else {
                        //ACTIVITIES LIST
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack(spacing: 10) {
                                ForEach(viewModel.activities) { activity in
                                    CardView(activity: activity)
                                }
                            }
                        }
                    }
                Spacer()
            }
            .padding(.horizontal, 17)
            .onAppear {
                    Task {
                        guard let token = appState.token else { return }
                        
                        await viewModel.getFilteredActivities(token: token, category: nil, duration: nil, period: nil)
                    }
            }
        }
    }
}

#Preview {
    ActivityView()
        .environment(AppState())
}
