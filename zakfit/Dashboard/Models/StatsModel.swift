//
//  StatsModel.swift
//  zakfit
//
//  Created by alize suchon on 03/12/2025.
//

import SwiftUI

struct Stat: Identifiable {
    var id = UUID()
    var type: String
    var value: Double
    var target: Double
    var color: Color
}
