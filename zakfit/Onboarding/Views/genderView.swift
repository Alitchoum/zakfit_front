//
//  genderView.swift
//  zakfit
//
//  Created by alize suchon on 28/11/2025.
//

import SwiftUI

struct genderView: View {
    
    let genderArray = ["Femme", "Homme", "Non binaire", "Ne préfère pas le dire"]
    @State var viewModel : OnboardingViewModel
    
    var body: some View {

            VStack{
                Text("Quel est votre genre ?")
                    .font(.custom("Parkinsans-SemiBold", size: 24))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 40)
                    .fixedSize(horizontal: false, vertical: true)
                
                ForEach(genderArray,  id: \.self) { (text: String) in
                    Button{
                        viewModel.gender = text
                    } label: {
                        ZStack{
                            Rectangle()
                                .frame(maxWidth: .infinity, maxHeight: 60)
                                .foregroundColor(.white)
                                .cornerRadius(15)
                            HStack{
                                Text(text)
                                    .font(.system(size: 17))
                                    .padding(.leading, 25)
                                Spacer()
                                Image(viewModel.gender == text ? "ratio1" :"ratio2")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .padding(.trailing, 15)
                            }
                        }
                    }
                    .foregroundColor(.black)
                }
            }
    }
}

#Preview {
    genderView(viewModel: OnboardingViewModel())
}
