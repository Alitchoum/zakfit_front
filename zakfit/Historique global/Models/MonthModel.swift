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
    MonthModel(picto: "fire", value: 2020, type: "Calories", color: .violet),
    MonthModel(picto: "repas", value: 38, type: "Repas ajoutés", color: .vert),
    MonthModel(picto: "light", value: 1700, type: "Calories brulées", color: .rose),
    MonthModel(picto: "sport", value: 16, type: "Entrainements", color: .bleu)
]
