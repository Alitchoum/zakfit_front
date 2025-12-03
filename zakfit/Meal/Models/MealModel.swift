//
//  MealModel.swift
//  zakfit
//
//  Created by alize suchon on 30/11/2025.
//

import SwiftUI

struct MealModel: Identifiable {
    var id: UUID = UUID()
    var type: String
    var value: Int
    var color : Color
}

let arrayInfos = [
    MealModel(type: "Calories", value: 45 ,color: .violet),
    MealModel(type: "Proteines", value: 65 ,color: .rose),
    MealModel(type: "Lipides", value: 5 ,color: .vert),
    MealModel(type: "Glucides", value: 15 ,color: .bleu),
]

let colorArray: [Color] = [.vert, .bleu, .rose, .violet]

