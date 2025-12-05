//
//  FoodViewmodel.swift
//  zakfit
//
//  Created by alize suchon on 04/12/2025.
//

import SwiftUI

@Observable
final class FoodViewModel{
    
    func deleteFood(food: FoodResponse) async {
        guard let url = URL(string: "http://127.0.0.1:8080/foodCategories") else { return }
        
        
        
        
    }
}
