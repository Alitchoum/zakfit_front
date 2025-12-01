//
//  ActivityModel.swift
//  zakfit
//
//  Created by alize suchon on 30/11/2025.
//

import SwiftUI

struct CategoryResponse: Identifiable, Codable {
    let id: UUID
    let name: String
    let picto: String
    let color: String
    let indexOrder: Int
}

struct ActivityDTO: Codable {
    let duration: Int
    let caloriesBurned: Int
    let date: Date
    let categoryId: UUID
}

struct ActivityResponse:  Identifiable, Codable {
    let id: UUID
    let duration: Int
    let caloriesBurned: Int
    let date: Date
    let categoryId: UUID
    let categoryName: String
    let categoryPicto: String
    let categoryColor: String
}
