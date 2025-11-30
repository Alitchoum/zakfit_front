//
//  ModaleNutriGoalModel.swift
//  zakfit
//
//  Created by alize suchon on 29/11/2025.
//

import SwiftUI

struct ModaleNutriGoalModel: Identifiable{
    var id = UUID()
    var title: String
    var description: String
    var buttonText: String
    var color: Color
}

let infosArray: [ModaleNutriGoalModel] = [
    ModaleNutriGoalModel(title: "Calcul automatique", description: "is a long established fact that a reader will be distracted.", buttonText:"Lancer" , color: .vert),
    ModaleNutriGoalModel(title: "Programme personnaliser", description: "is a long established fact that a reader will be distracted.", buttonText:"Personnaliser" , color: .violet)
]
