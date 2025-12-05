//
//  registerView.swift
//  zakfit
//
//  Created by alize suchon on 26/11/2025.
//

import SwiftUI

struct LoginView: View {
    
    @Environment(AppState.self) private var appState
    @State private var email = ""
    @State private var password = ""
    @State private var showMPD = false
    @State private var errorMessage: String?
    @State private var isLoading = false
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                Color.violetC
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Image("hello")
                        .resizable()
                        .frame(width: 126, height: 126)
                    
                    Text("Se connecter")
                        .font(.custom("Parkinsans-SemiBold", size: 24))
                        .padding(.bottom, 40)
                    
                    // EMAIL
                    TextField("Email", text: $email)
                        .padding(.horizontal, 20)
                        .frame(height: 50)
                        .background(.white)
                        .cornerRadius(15)
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                    
                    // PASSWORD
                    ZStack {
                        if !showMPD {
                            SecureField("Mot de passe", text: $password)
                                .padding(.horizontal, 20)
                                .frame(height: 50)
                                .background(.white)
                                .cornerRadius(15)
                                .disableAutocorrection(true)
                        } else {
                            TextField("Mot de passe", text: $password)
                                .padding(.horizontal, 20)
                                .frame(height: 50)
                                .background(.white)
                                .cornerRadius(15)
                                .disableAutocorrection(true)
                        }
                        
                        HStack {
                            Spacer()
                            Button {
                                showMPD.toggle()
                            } label: {
                                Image("oeil")
                                    .frame(width: 25, height: 17)
                            }
                        }
                        .padding(.trailing, 15)
                    }
                    
                    // ERROR MESSAGE
                    if let error = errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .font(.custom("DMSans-Regular", size: 14))
                            .multilineTextAlignment(.center)
                    }
                    
                    // SE CONNECTER
                    Button {
                        Task {
                            await login()
                        }
                    } label: {
                        ZStack(alignment: .center) {
                            Rectangle()
                                .frame(height: 50)
                                .foregroundColor(.black)
                                .cornerRadius(15)
                            
                            if isLoading {
                                ProgressView()
                                    .tint(.white)
                            } else {
                                Text("Se connecter")
                                    .font(.custom("Parkinsans-Medium", size: 16))
                                    .foregroundColor(.white)
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .disabled(isLoading)
                    
                    HStack(spacing: 2) {
                        Text("Vous n'avez pas de compte ?")
                        NavigationLink(destination: RegisterView()) {
                            Text("Créer un compte")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.black)
                        }
                    }
                }
                .padding(.horizontal, 17)
            }
        }
    }
    
    // ✅ Fonction login directement dans la vue
    private func login() async {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Veuillez remplir tous les champs."
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        do {
            let response = try await UserService.login(email: email, password: password)
            
            await MainActor.run {
                appState.login(user: response.user, token: response.token, needsOnboarding: false)
            }
            
        } catch {
            await MainActor.run {
                errorMessage = "Erreur de connexion: \(error.localizedDescription)"
                isLoading = false
            }
            print("❌ Login error: \(error)")
        }
    }
}

#Preview {
    LoginView()
        .environment(AppState())
}

#Preview {
    LoginView()
        .environment(AppState())
}
