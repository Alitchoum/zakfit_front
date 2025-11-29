//
//  LoginView.swift
//  zakfit
//
//  Created by alize suchon on 26/11/2025.
//


import SwiftUI

struct RegisterView: View {
    
    @Environment(AppState.self) var appState
    @State private var viewModelRegister = RegistrerViewModel()
    @State var showMPD: Bool = false
    @State var showMPDConfifm: Bool = false
    
    var body: some View {
        ZStack {
            Color.violetC
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Image("hello")
                    .resizable()
                    .frame(width: 126, height: 126)
                Text("Créer un compte")
                    .font(.custom("Parkinsans-SemiBold", size: 24))
                    .padding(.bottom, 40)
                
                //Prénom
                TextField("Prénom", text: $viewModelRegister.firstName)
                    .padding(.horizontal, 20)
                    .frame(height: 50)
                    .background(.white)
                    .cornerRadius(15)
                    .disableAutocorrection(true)
                
                //Nom
                TextField("Nom", text:  $viewModelRegister.lastName)
                    .padding(.horizontal, 20)
                    .frame(height: 50)
                    .background(.white)
                    .cornerRadius(15)
                    .disableAutocorrection(true)
                
                //Email
                TextField("Email", text:  $viewModelRegister.email)
                    .padding(.horizontal, 20)
                    .frame(height: 50)
                    .background(.white)
                    .cornerRadius(15)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                
                //MPD
                ZStack{
                    if !showMPD {
                        SecureField("Mot de passe", text:  $viewModelRegister.password)
                            .padding(.horizontal, 20)
                            .frame(height: 50)
                            .background(.white)
                            .cornerRadius(15)
                            .disableAutocorrection(true)
                            .textInputAutocapitalization(.never)
                    } else {
                        TextField("Mot de passe", text:  $viewModelRegister.password)
                            .padding(.horizontal, 20)
                            .frame(height: 50)
                            .background(.white)
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
                
                //confirm MPD
                ZStack{
                    if !showMPDConfifm {
                        SecureField("Confirmation mot de passe", text:  $viewModelRegister.confirmPassword)
                            .padding(.horizontal, 20)
                            .frame(height: 50)
                            .background(.white)
                            .cornerRadius(15)
                            .disableAutocorrection(true)
                            .textInputAutocapitalization(.never)
                    } else {
                        TextField("Confirmation mot de passe", text:  $viewModelRegister.confirmPassword)
                            .padding(.horizontal, 20)
                            .frame(height: 50)
                            .background(.white)
                            .cornerRadius(15)
                            .disableAutocorrection(true)
                            .textInputAutocapitalization(.never)
                    }
                    
                    HStack{
                        Spacer()
                        Button{
                            showMPDConfifm.toggle()
                        } label: {
                            Image("oeil")
                                .frame(width: 25, height: 17)
                        }
                    }
                    .padding(.trailing, 15)
                }
                
                // Message d'erreur
                if let errorMessage = viewModelRegister.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.custom("DMSans-Regular", size: 16))
                        .multilineTextAlignment(.center)
                }
                
                //validation inscription
                Button{
                    Task { await viewModelRegister.register() }
                } label: {
                    ZStack(alignment: .center) {
                        Rectangle()
                            .foregroundColor(.black)
                            .cornerRadius(15)
                        Text("Créer un compte")
                            .font(.custom("Parkinsans-Medium", size: 16))
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                }
                HStack(spacing: 4){
                    Text("Avez-vous un compte ?")
                        .font(.custom("DMSans-Regular", size: 16))
                    
                    //NAVIGATION VERS LOGIN
                    NavigationLink(destination: LoginView()) { //  MARCHE PAS
                        Text("Se connecter")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.black)
                    }
                }
            }
            .padding(.horizontal, 17)
            .onChange(of: viewModelRegister.isRegistered) { _, isRegistered in
                if isRegistered,
                   let user = viewModelRegister.registeredUser,
                   let token = viewModelRegister.receivedToken {
                    appState.login(user: user, token: token)
                    appState.isOnboardingNeeded = true
                }
            }
        }
    }
}

#Preview {
    RegisterView()
        .environment(AppState())
}

//struct RegisterPreviews: PreviewProvider {
//    static var previews: some View {
//        let previewState = AppState()
//        previewState.token = "dummy"
//        previewState.user = User(firstName: "Alice", lastName: "Z", email: "a@a.com", password: "123", weight: 45, size: 167, objective: "", diet: "", gender: "female", birthday: Date())
//
//        return RegisterView()
//            .environment(previewState)
//    }
//}

