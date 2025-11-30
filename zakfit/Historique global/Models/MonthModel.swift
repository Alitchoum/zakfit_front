//
//  MonthModel.swift
//  zakfit
//
//  Created by alize suchon on 30/11/2025.
//

import SwiftUI

struct MonthModel: Identifiable {
    var id = UUID()
    var picto : String
    var value: Int
    var type: String
    var color: Color
}

let arrayMonth: [MonthModel] = [
    MonthModel(picto: "feu", value: 200, type: "Calories", color: .violet),
    MonthModel(picto: "repas", value: 2, type: "Repas enregistrés", color: .vert),
    MonthModel(picto: "light", value: 100, type: "Calories brulées", color: .rose),
    MonthModel(picto: "sport", value: 10, type: "Entrainements", color: .bleu)
]
