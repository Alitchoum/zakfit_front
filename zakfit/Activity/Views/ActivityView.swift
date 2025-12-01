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
    
    var body: some View {
        VStack{
            Text("Mes activités")
                .font(.custom("Parkinsans-SemiBold", size: 24))
                .padding(.bottom, 40)
            
            HStack{
                //BUTTON FILTERS
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
            
            //ACTIVITIES LIST
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 15) {
                    ForEach(viewModel.activities) { activity in
                        CardView(activity: activity)
                    }
                }
            }
        }
        .padding(.horizontal, 17)
        .onAppear {
            Task {
                guard let token = appState.token else {
                    return print("Error token")
                }
                await viewModel.fetchActivities(token:token)
            }
        }
    }
}

#Preview {
    ActivityView()
        .environment(AppState())
}
