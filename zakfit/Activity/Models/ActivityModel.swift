//
//  ActivityModel.swift
//  zakfit
//
//  Created by alize suchon on 30/11/2025.
//

import SwiftUI

struct ActivityModel: Identifiable {
    var id: UUID = UUID()
    var name: String
    var picto: String
    var caloriesBurned: Int
    var duration: Int
    var date: Date
    var color: Color
}
