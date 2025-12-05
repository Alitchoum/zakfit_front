//
//  SettingView.swift
//  zakfit
//
//  Created by alize suchon on 24/11/2025.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(AppState.self) var appState
    @Environment(\.dismiss) private var dismiss
    @State private var notificationsOn = false
    @State var MPD  = ""
    @State var showMPD = false
    @State var showAlert = false
    
    var body: some View {
        VStack(spacing : 15){
            Text("Gérer mon compte")
                .font(.custom("Parkinsans-SemiBold", size:24))
                .foregroundColor(.black)
                .padding(.bottom, 40)
            
            // NOTIFICATIONS
            Toggle(isOn: $notificationsOn) {
                Text("Notifications")
            }
            .tint(.violet)

            //FIRST NAME
            TextField("Prénom", text: Binding(
                get: { appState.user?.firstName ?? "Vide" },
                set: { appState.user?.firstName = $0 }
            ))
            .padding(.horizontal, 20)
            .frame(height: 50)
            .background(.gris)
            .cornerRadius(15)
            .disableAutocorrection(true)
            
            //LAST NAME
            TextField("Nom", text: Binding(
                get: { appState.user?.lastName ?? "Vide" },
                set: { appState.user?.lastName = $0 }
            ))
            .padding(.horizontal, 20)
            .frame(height: 50)
            .background(.gris)
            .cornerRadius(15)
            .disableAutocorrection(true)
            
            //EMAIL
            TextField("Email", text: Binding(
                get: { appState.user?.email ?? "Vide"},
                set: { appState.user?.email = $0}
            ))
            .padding(.horizontal, 20)
            .frame(height: 50)
            .background(.gris)
            .cornerRadius(15)
            .disableAutocorrection(true)
            .textInputAutocapitalization(.never)
            
            //PASSWORD
            ZStack{
                if showMPD {
                    TextField("Mot de passe", text: $MPD)
                        .padding(.horizontal, 20)
                        .frame(height: 50)
                        .background(.gris)
                        .cornerRadius(15)
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                } else {
                    SecureField("Mot de passe", text: $MPD)
                        .padding(.horizontal, 20)
                        .frame(height: 50)
                        .background(.gris)
                        .cornerRadius(15)
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                }
                HStack{
                    Spacer()
                    Button{
                        showMPD.toggle()
                    } label: {
                        Image("oeil")
                            .frame(width: 25, height: 17)
                    }
                }
                .padding(.trailing, 15)
            }
            //MEASURES
            HStack{
                TextField("poids/kg", text: Binding(
                    get: { if let weight = appState.user?.weight {
                        return String(weight)
                    } else {
                        return "Vide"
                    }},
                    set: { appState.user?.weight = Int($0) }
                ))
                .padding(.horizontal, 20)
                .frame(height: 50)
                .background(.gris)
                .cornerRadius(15)
                .disableAutocorrection(true)
                Text("kg")
                    .padding(.trailing, 10)
                TextField("taille/cm", text: Binding(
                    get: {
                        if let size = appState.user?.size {
                            return String(size)
                        } else {
                            return "Vide"
                        }},
                    set: { appState.user?.size = Int($0) ?? 0}
                ))
                .padding(.horizontal, 20)
                .frame(height: 50)
                .background(.gris)
                .cornerRadius(15)
                .disableAutocorrection(true)
                Text("cm")
            }
            //OBJECTIVE
            HStack{
                TextField("Votre objectif", text: Binding(
                    get: { if let weight = appState.user?.objective {
                        return String(weight)
                    } else {
                        return "Vide"
                    }},
                    set: { appState.user?.objective = $0 }
                ))
                .padding(.horizontal, 20)
                .frame(height: 50)
                .background(.gris)
                .cornerRadius(15)
                .disableAutocorrection(true)
            }
            
            //MODIFIER
            Button{
                Task {
                    guard let token = appState.token else { return }
                    
                    let data = UpdateUserDTO(
                        firstName: appState.user?.firstName,
                        lastName: appState.user?.lastName,
                        email: appState.user?.email,
                        password: MPD.isEmpty ? nil : MPD,
                        weight: appState.user?.weight,
                        size: appState.user?.size,
                        objective: appState.user?.objective
                    )
                    
                    do {
                        let updatedUser = try await UserService.updateUser(token: token, updateData: data)
                        
                        await MainActor.run {
                            appState.user = updatedUser
                        }
                        
                    } catch {
                        print("Error update profile")
                    }
                }
            } label: {
                ZStack(alignment: .center) {
                    Rectangle()
                        .foregroundColor(.black)
                        .cornerRadius(15)
                    Text("Modifier")
                        .font(.custom("Parkinsans-Medium", size: 16))
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 50)
            }
            .padding(.top, 30)
            .alert("Modifications enregistrées 👌​!", isPresented: $showAlert) {
                Button("OK", role: .cancel) {
                    dismiss()
                }
            }
            
            //DECONNEXION
            Button{
                appState.logout()
            } label: {
                ZStack(alignment: .center) {
                    Rectangle()
                    
                        .foregroundColor(.violet)
                        .cornerRadius(15)
                    Text("Deconnexion")
                        .font(.custom("Parkinsans-Medium", size: 16))
                        .foregroundColor(.black)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 50)
            }
        }
        .padding(.horizontal, 17)
    }
}

#Preview {
    SettingsView()
        .environment(AppState())
}
