//
//  ChooseDishTypeModel.swift
//  zakfit
//
//  Created by alize suchon on 28/11/2025.
//

import SwiftUI

struct MealType: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var picto: String
    var color: Color
}

let MealTypeArray = [
    MealType(name: "Petit-déjeuner", picto: "breakfast", color: .bleuC),
    MealType(name: "Déjeuner", picto: "dej", color: .vertC),
    MealType(name: "Collation", picto: "donut", color: .roseC),
    MealType(name: "Dîner", picto: "diner", color: .violetC)
]
