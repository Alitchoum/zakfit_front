//
//  userModel$.swift
//  zakfit
//
//  Created by alize suchon on 27/11/2025.
//

import SwiftUI

struct User : Codable {
    var firstName: String
    var lastName: String
    var email: String
    var weight: Int?
    var size: Int?
    var objective: String?
    var diet: String?
    var gender: String?
    var birthday: Date?
    
    var age : Int? {
        guard let birthday else { return nil }
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: birthday, to: Date())
        return ageComponents.year
    }
}
