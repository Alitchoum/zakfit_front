//
//  MealViewModel.swift
//  zakfit
//
//  Created by alize suchon on 30/11/2025.
//

import SwiftUI

struct Meal: Codable {
    var type: String
    var image: String?
    var picto : String
    var totalCalories : Double
    var totalCarbs : Double
    var totalProteins : Double
    var totalFats : Double
    var date : Date
}

@Observable
final class MealViewModel {
    
}
