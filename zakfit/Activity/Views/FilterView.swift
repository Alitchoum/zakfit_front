//
//  FilterView.swift
//  zakfit
//
//  Created by alize suchon on 30/11/2025.
//

import SwiftUI

struct FilterView: View {
    
    @Environment(AppState.self) private var appState
    @Environment(\.dismiss) private var dismiss
    @Bindable var viewModel : ActivityViewModel
    @State var selectedCat = ""
    @State var selectedDuration = ""
    @State var selectedPeriod = ""
    
    let sportArray = ["Cyclisme", "Course à pied", "Musculation", "Yoga", "Natation", "Sport de combat", "Sport de raquette", "Sport de ballon"]
    let durationArray = ["0-1h", "1h-3h", "3h-6h"]
    let periodeArray = ["Aujourd'hui", "Cette semaine", "Ce mois-ci"]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(alignment: .leading){
                HStack{
                    Text("Filtres")
                        .font(.custom("Parkinsans-SemiBold", size: 24))
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
                }
                .padding(.vertical, 20)
                
                Text("Catégories")
                    .font(.custom("Parkinsans-Medium", size: 20))
                ZStack{
                    Rectangle()
                        .frame(maxWidth: .infinity)
                        .cornerRadius(15)
                        .foregroundColor(.gris)
                    VStack (alignment: .leading, spacing: 15){
                        ForEach(sportArray, id: \.self) { item in
                            HStack{
                                Text(item)
                                    .font(.system(size:16))
                                Spacer()
                                
                                Button{
                                    if selectedCat == item {
                                        selectedCat = ""
                                    } else {
                                        selectedCat = item
                                    }
                                }label: {
                                    Image(selectedCat == item ? "ratio1" : "ratio2")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                }
                            }
                        }
                    }
                    .padding(20)
                }
                
                //SELECT DURATION
                Text("Durée")
                    .font(.custom("Parkinsans-Medium", size: 20))
                ZStack{
                    Rectangle()
                        .frame(maxWidth: .infinity)
                        .cornerRadius(15)
                        .foregroundColor(.gris)
                    VStack (alignment: .leading, spacing: 15){
                        ForEach(durationArray, id: \.self) { item in
                            HStack{
                                Text(item)
                                    .font(.system(size:16))
                                Spacer()
                                
                                Button{
                                    if selectedDuration == item {
                                        selectedDuration = ""
                                    } else {
                                        selectedDuration = item
                                    }
                                }label: {
                                    Image(selectedDuration == item ? "ratio1" : "ratio2")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                }
                            }
                        }
                    }
                    .padding(20)
                }
                
//                //SELECT PERIOD
//                Text("Sélectionner une période")
//                    .font(.custom("Parkinsans-Medium", size: 20))
                
                HStack{
                    //REFRESH FILTRES
                    Button{
                        selectedCat = ""
                        selectedDuration = ""
                        selectedPeriod = ""
                    }label:{
                        ZStack{
                            Rectangle()
                                .foregroundColor(.black)
                                .cornerRadius(15)
                            Text("Réinitialiser")
                                .font(.custom("Parkinsans-Medium", size: 16))
                                .foregroundColor(.white)
                        }
                        .frame(height: 50)
                        .padding(.top, 20)
                    }
                    //APPLIQUER FILTRES
                    Button{
                        Task {
                            guard let token = appState.token else { return }
                            
                            await viewModel.getFilteredActivities(token: token, category: selectedCat.isEmpty ? nil : selectedCat, duration: selectedDuration.isEmpty ? nil : selectedDuration, period: selectedPeriod.isEmpty ? nil : selectedPeriod)
                            dismiss()
                        }
                    }label:{
                        ZStack{
                            Rectangle()
                                .foregroundColor(.black)
                                .cornerRadius(15)
                            Text("Appliquer")
                                .font(.custom("Parkinsans-Medium", size: 16))
                                .foregroundColor(.white)
                        }
                        .frame(height: 50)
                        .padding(.top, 20)
                    }
                }
            }
            .padding(.horizontal, 17)
        }
    }
}

#Preview {
    FilterView(viewModel: ActivityViewModel())
        .environment(AppState())
    
}
