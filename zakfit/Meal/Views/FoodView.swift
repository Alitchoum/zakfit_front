//
//  FoodView.swift
//  zakfit
//
//  Created by alize suchon on 30/11/2025.
//

import SwiftUI

struct FoodView: View {
    
    let backgroundArray = ["fondViolet", "fondRose", "fondVert", "fondBleu"]
    
    @State private var columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(.black)
                .cornerRadius(15)
                .frame(width: 50, height: 6)
                .padding(.bottom, 30)
                .padding(.top, 20)
            
            Text("Pastèque")
                .font(.custom("Parkinsans-SemiBold", size: 25))
                .padding(.bottom, 25)
            
            Text("Quantité")
                .font(.custom("Parkinsans-Medium", size: 20))
            //QUANTITY
            HStack{
                TextField("Quantité", text: .constant(""))
                    .padding(.horizontal, 20)
                    .frame(height: 50)
                    .background(.gris)
                    .cornerRadius(15)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
 
                    ZStack{
                    Rectangle()
                        .foregroundColor(.black)
                        .cornerRadius(15)
                    Text("100 g")
                        .font(.custom("Parkinsans-Medium", size: 16))
                        .foregroundColor(.white)
                }
                .frame(height: 50)
            }
            .padding(.bottom, 20)
            
            Text("Apports nutritionnels")
                .font(.custom("Parkinsans-Medium", size: 20))
                .padding(.bottom, 20)
            
            ZStack{
                LazyVGrid(columns: columns, spacing: 10){
                    ForEach (backgroundArray, id: \.self) { img in
                        Image("\(img)")
                    }
                }
                VStack{
                    ZStack{
                        Rectangle()
                            .cornerRadius(15)
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                        Image("feu")
                            .resizable()
                            .frame(width: 27, height: 27)
                    }
                    Text("Calories")
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                    Text("100 g")
                        .font(.custom("Parkinsans-SemiBold", size: 20))
                        .foregroundColor(.black)
                }
            }
            
            //BUTTON
            Button{
                //Logique
            }label: {
                ZStack{
                Rectangle()
                    .foregroundColor(.black)
                    .cornerRadius(15)
                Text("Ajouter")
                    .font(.custom("Parkinsans-Medium", size: 16))
                    .foregroundColor(.white)
            }
            .frame(height: 50)
            }
            
        }
        .padding(.horizontal, 17)
    }
}

#Preview {
    FoodView()
}
