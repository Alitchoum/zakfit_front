//
//  registerView.swift
//  zakfit
//
//  Created by alize suchon on 26/11/2025.
//

import SwiftUI

struct LoginView: View {
    
    // @State private var showPassword: Bool = false
    @Environment(AppState.self) private var appState
    @State private var viewModelLogin: LoginViewModel
    @State var showMPD: Bool = false
    
    init() {
        // On initialise le ViewModel AVEC l’AppState (injection)
        let appState = AppState()   // ⚠️ sera remplacé par @Environment ensuite
        _viewModelLogin = State(initialValue: LoginViewModel(appState: appState))
    }
    
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
                
                //EMAIL
                TextField("Email", text: .constant(""))
                    .padding(.horizontal, 20)
                    .frame(height: 50)
                    .background(.white)
                    .cornerRadius(15)
                    .disableAutocorrection(true)
                
                //MPD
                ZStack{
                    if !showMPD {
                        SecureField("Mot de passe", text:  $viewModelLogin.password)
                            .padding(.horizontal, 20)
                            .frame(height: 50)
                            .background(.white)
                            .cornerRadius(15)
                            .disableAutocorrection(true)
                    } else {
                        TextField("Mot de passe", text:  $viewModelLogin.password)
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
                
                //CRÉER COMPTE
                Button{
                    Task {
                        viewModelLogin.appState = appState
                        await viewModelLogin.login()
                    }
                } label: {
                    ZStack(alignment: .center) {
                        Rectangle()
                            .frame(width: .infinity, height: 50)
                            .foregroundColor(.black)
                            .cornerRadius(15)
                        Text("Créer un compte")
                            .font(.custom("Parkinsans-Medium", size: 16))
                            .foregroundColor(.white)
                    }
                }
                HStack(spacing:2){
                    Text("Vous n’avez pas de compte ?")
                    Text(" Créer un compte")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)
                }
            }
            .padding(.horizontal, 17)
        }
        
    }
}

    #Preview {
        LoginView()
    }

//// ✅ Preview test
//struct LoginViewPreviews: PreviewProvider {
//    static var previews: some View {
//        let previewState = AppState()
//        previewState.token = "dummy"
//        previewState.user = User(firstName: "Alice", lastName: "Z", email: "a@a.com", weight: 45, size: 167, objective: "", diet: "", gender: "female", birthday: Date())
//        
//        return LoginView()
//            .environment(previewState)
//    }
//}
