//
//  MealModel.swift
//  zakfit
//
//  Created by alize suchon on 30/11/2025.
//

import SwiftUI

//VIEW MEAL
struct MealModel: Identifiable {
    var id: UUID = UUID()
    var type: String
    var value: Double
    var color : Color
    var picto : String
}

//VIEW MY MEALS
struct MyMealsModel: Identifiable {
    var id: UUID = UUID()
    var type: String
    var back: Color
    var color : Color
}

let colorArray: [Color] = [.vert, .bleu, .rose, .violet]

