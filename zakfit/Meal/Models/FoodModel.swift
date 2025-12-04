//
//  FoodModel.swift
//  zakfit
//
//  Created by alize suchon on 02/12/2025.
//

import SwiftUI

struct FoodModel: Identifiable {
    var id: UUID = UUID()
    var back: Color
    var picto: String
    var color: Color
    var name: String
}

let foodModelArray: [FoodModel] = [
    FoodModel(back: .violetC, picto: "fire", color: .violet, name: "Calories"),
    FoodModel(back: .roseC, picto: "fish-simple", color: .rose,  name: "Proteines"),
    FoodModel(back: .vertC, picto: "avocado", color: .vert, name: "Lipides"),
    FoodModel(back: .bleuC, picto: "ble", color: .bleu,  name: "Glucides")
]

func calculApport(food: FoodResponse, nutriment: String, quantite: Int) -> String {
    var result: Double = 0
    
    switch nutriment {
    case "Calories":
        result = food.calories100g * Double(quantite) / 100
    case "Proteines":
        result = food.proteins100g * Double(quantite) / 100
    case "Lipides":
        result = food.fats100g * Double(quantite) / 100
    case "Glucides":
        result = food.carbs100g * Double(quantite) / 100
    default:
        break
    }
    return String(format: "%.1f", result)
}
