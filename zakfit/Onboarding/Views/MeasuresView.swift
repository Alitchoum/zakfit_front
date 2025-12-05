//
//  MeasuresView.swift
//  zakfit
//
//  Created by alize suchon on 28/11/2025.
//

import SwiftUI

struct MeasuresView: View {
    
    @State var viewModel : OnboardingViewModel
    
    @State private var weightText = ""
    @State private var sizeText = ""
    
    var body: some View {
        
        VStack (spacing: 30){
            Text("Quelles sont vos mensurations ?")
                .font(.custom("Parkinsans-SemiBold", size: 24))
                .multilineTextAlignment(.center)
                .padding(.bottom, 40)
                .fixedSize(horizontal: false, vertical: true)
            
            //POIDS
            VStack (alignment: .leading, spacing: 20){
                Text("Quel est votre poids ?")
                    .font(.custom("Parkinsans-SemiBold", size: 17))
                
                HStack(spacing:10){
                    TextField("Votre poids", text: $weightText)
                        .padding(.horizontal, 20)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(.white)
                        .cornerRadius(15)
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.numberPad)
                        .onChange(of: weightText) { _ , newText in
                            let onlyNumber = newText.filter{$0.isNumber }
                            if newText != onlyNumber {
                                weightText = onlyNumber
                            }
                                viewModel.weight = Int(onlyNumber) ?? 0
                        }
                    
                    ZStack{
                        Rectangle()
                            .frame(width: 85,height: 50)
                            .cornerRadius(15)
                        Text("Kilos")
                            .foregroundColor(.white)
                    }
                }
            }
            //TAILLE
            VStack (alignment: .leading, spacing: 20){
                Text("Quel est votre taille ?")
                    .font(.custom("Parkinsans-SemiBold", size: 17))
                
                HStack(spacing: 10){
                    TextField("Votre taille", text: $sizeText)
                        .padding(.horizontal, 20)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(.white)
                        .cornerRadius(15)
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.numberPad)
                    
                        .onChange(of: sizeText) { _ , newText in
                            let onlyNumber = newText.filter{$0.isNumber}
                            if newText != onlyNumber {
                                sizeText = onlyNumber
                            }
                                viewModel.size = Int(onlyNumber) ?? 0
                            }
                    ZStack{
                        Rectangle()
                            .frame(width: 85,height: 50)
                            .cornerRadius(15)
                        Text("cm")
                            .foregroundColor(.white)
                    }
                }
                }
            }
        }
    }


#Preview {
    MeasuresView(viewModel: OnboardingViewModel())
}
