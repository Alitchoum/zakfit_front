//
//  DietView.swift
//  zakfit
//
//  Created by alize suchon on 28/11/2025.
//

import SwiftUI

struct DietView: View {
    
    let textArray = ["Mange de tout", "Végétarien", "Végan", "Flexitarien", "Sans gluten", "Sans lactose"]

    @State var viewModel : OnboardingViewModel
    
    var body: some View {
       
            VStack (spacing: 15){
                Text("Quel est votre régime alimentaire ?")
                    .font(.custom("Parkinsans-SemiBold", size: 24))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 40)
                    .fixedSize(horizontal: false, vertical: true)
                
                ForEach(textArray, id: \.self) { (text: String) in
                    
                    Button{
                        viewModel.diet = text
                    }label: {
                        ZStack{
                            Rectangle()
                                .frame(maxWidth: .infinity, maxHeight: 60)
                                .cornerRadius(15)
                                .foregroundColor(.white)
                            HStack{
                                Text(text)
                                    .font(.system(size: 17))
                                    .padding(.leading, 25)
                                Spacer()
                                Image(viewModel.diet == text ? "ratio1" :"ratio2")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .padding(.trailing, 15)
                            }
                        }
                    }
                    .foregroundColor(.black)
                }
            }
//            .background(.violetC)
//            .padding(.horizontal, 17)
        }
    }


#Preview {
    DietView(viewModel:OnboardingViewModel())
}
