//
//  OnboardingView.swift
//  zakfit
//
//  Created by alize suchon on 26/11/2025.
//

import SwiftUI

struct OnboardingView: View {
    
    @Environment(AppState.self) private var appState
    @State var viewModel = OnboardingViewModel()
    
    var body: some View {
        ZStack {
            Color.violetC
                .ignoresSafeArea()
            VStack {
                //PROGRESS VIEW
                ProgressView(value: viewModel.progress())
                    .progressViewStyle(
                        LinearProgressViewStyle(tint: Color.black)
                    )
                    .padding(.horizontal, 25)
                    .padding(.top, 70)
                    .padding(.bottom, 50)
                Spacer()
                
                //AFFICHAGE VIEW
                switch viewModel.currentPage {
                case 0:
                    AgeView(viewModel: viewModel)
                case 1:
                    MeasuresView(viewModel: viewModel)
                case 2:
                    genderView(viewModel: viewModel)
                case 3:
                    ObjectiveView(viewModel: viewModel)
                case 4:
                    DietView(viewModel: viewModel)
                default:
                    EmptyView()
                }
                Spacer()
                
                //MESSAGES ERREURS (!!revoir l'apparition!!)
                if !viewModel.okForNext(current: viewModel.currentPage) {
                    Text(viewModel.ViewMessage(current: viewModel.currentPage))
                        .foregroundColor(.red)
                        .font(.system(size: 16))
                        .padding(.bottom, 8)
                }
                
                //BUTTON
                Button{
                    guard viewModel.okForNext(current: viewModel.currentPage) else { return }
                    if viewModel.currentPage == viewModel.NbPage - 1 {
                        Task {
                            guard let token = appState.token else { return }
                            
                            await viewModel.updateDataUser(token: token)
                            await appState.loadCurrentUser()
                            appState.completeOnboarding()
                        }
                    } else {
                        viewModel.nextPage()
                    }
                } label: {
                    ZStack() {
                        Rectangle()
                            .frame(width: 170,height: 50)
                            .cornerRadius(15)
                            .foregroundColor(.black)
                        Text(viewModel.currentPage == viewModel.NbPage - 1 ? "Terminer" : "Suivant")
                            .font(.custom("Parkinsans-Medium", size: 16))
                            .foregroundColor(.white)
                    }
                }
                
            }
            .padding(.horizontal, 17)
        }
    }
}
    
#Preview {
    OnboardingView(viewModel: OnboardingViewModel())
        .environment(AppState())
}
