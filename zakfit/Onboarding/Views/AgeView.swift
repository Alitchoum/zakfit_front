//
//  AgeSelectorView.swift
//  zakfit
//
//  Created by alize suchon on 28/11/2025.
//

import SwiftUI

struct AgeView: View {
    
    @State var dateSelected : Date?
    @State private var internalDate = Date()
    @State var viewModel : OnboardingViewModel
    
    var body: some View {
        
        VStack(alignment: .center){
            Text("Quel est votre date de naissance ?")
                .font(.custom("Parkinsans-SemiBold", size: 24))
                .multilineTextAlignment(.center)
                .padding(.bottom, 60)
            ZStack(alignment: .center){
                Rectangle()
                    .foregroundColor(.white)
                    .frame(width: 300, height: 35)
                    .frame(width: 300, height: 35)
                    .cornerRadius(15)
                    .padding(.leading, 10)
                DatePicker(
                    "",
                    selection: $viewModel.birthday,
                    in: ...Date(),
                    displayedComponents: .date
                )
                .datePickerStyle(.wheel)
                .padding()
            }
            Spacer()
        }
    }
}

#Preview {
    AgeView(viewModel: OnboardingViewModel())
}
