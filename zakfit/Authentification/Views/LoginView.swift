//
//  registerView.swift
//  zakfit
//
//  Created by alize suchon on 26/11/2025.
//

import SwiftUI

struct LoginView: View {
    
    @Environment(AppState.self) private var appState
    @State private var viewModel = LoginViewModel() 
    @State var showMPD: Bool = false
    
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
                    
                    //EMAIL
                    TextField("Email", text: $viewModel.email)
                        .padding(.horizontal, 20)
                        .frame(height: 50)
                        .background(.white)
                        .cornerRadius(15)
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                    //MPD
                    ZStack{
                        if !showMPD {
                            SecureField("Mot de passe", text:  $viewModel.password)
                                .padding(.horizontal, 20)
                                .frame(height: 50)
                                .background(.white)
                                .cornerRadius(15)
                                .disableAutocorrection(true)
                        } else {
                            TextField("Mot de passe", text:  $viewModel.password)
                                .padding(.horizontal, 20)
                                .frame(height: 50)
                                .background(.white)
                                .cornerRadius(15)
                                .disableAutocorrection(true)
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
                    
                    //SE CONNECTER
                    Button{
                        Task {
                            await viewModel.login()
                        }
                    } label: {
                        ZStack(alignment: .center) {
                            Rectangle()
                                .frame(height: 50)
                                .foregroundColor(.black)
                                .cornerRadius(15)
                            Text("Se connecter")
                                .font(.custom("Parkinsans-Medium", size: 16))
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    HStack(spacing:2){
                        Text("Vous n’avez pas de compte ?")
                        NavigationLink(destination: RegisterView()) {
                            Text("Créer un compte")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.black)
                        }
                    }
                }
                .padding(.horizontal, 17)
                .onAppear {
                    viewModel.appState = appState
                }
            }
        }
    }
}


#Preview {
    LoginView()
        .environment(AppState())
}
