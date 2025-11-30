//
//  ChooseDishTypeModel.swift
//  zakfit
//
//  Created by alize suchon on 28/11/2025.
//

import SwiftUI

struct MealType: Identifiable {
    let id = UUID()
    var name: String
    var image: String
    var color: Color
}

let MealArray = [
    MealType(name: "Petit-déjeuner", image: "breakfast", color: .bleuC),
    MealType(name: "Déjeuner", image: "dej", color: .vertC),
    MealType(name: "Collation", image: "donut", color: .roseC),
    MealType(name: "Dîner", image: "diner", color: .violetC)
]
