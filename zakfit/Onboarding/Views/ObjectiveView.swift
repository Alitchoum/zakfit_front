//
//  ObjectiveView.swift
//  zakfit
//
//  Created by alize suchon on 28/11/2025.
//

import SwiftUI

struct ObjectiveView: View {
    
    let textArray = ["Perdre du poids", "Prendre du muscle", "Maintenir mon poids"]
    @State var viewModel : OnboardingViewModel
    
    var body: some View {
      
            VStack{
                Text("Quel est votre objectif ?")
                    .font(.custom("Parkinsans-SemiBold", size: 24))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 40)
                
                ForEach(textArray, id: \.self) { (text : String) in
                    
                    Button {
                        viewModel.objective = text
                    } label: {
                        ZStack{
                            Rectangle()
                                .frame(maxWidth: .infinity, maxHeight: 60)
                                .foregroundColor(.white)
                                .cornerRadius(15)
                            HStack{
                                Text(text)
                                    .font(.system( size: 17))
                                    .foregroundColor(.black)
                                    .padding(.leading, 25)
                                Spacer()
                                Image(viewModel.objective == text ? "ratio1" : "ratio2")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .padding(.trailing, 15)
                            }
                        }
                    }
                }
            }
        //.background(.violetC)
            //.padding(.horizontal, 17)
    }
}

#Preview {
    ObjectiveView(viewModel: OnboardingViewModel())
}
