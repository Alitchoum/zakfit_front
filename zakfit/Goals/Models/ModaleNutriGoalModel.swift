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
    ModaleNutriGoalModel(title: "Calcul automatique", description: "Estimation de vos besoins caloriques journaliers selon votre objectif.", buttonText:"Lancer" , color: .vert),
    ModaleNutriGoalModel(title: "Programme personnaliser", description: "Créez un plan nutritionnel sur-mesure en définissant vos calories et vos macros.", buttonText:"Personnaliser" , color: .violet)
]
