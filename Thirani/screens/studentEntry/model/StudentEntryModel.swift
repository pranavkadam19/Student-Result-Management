//
//  Model.swift
//  Thirani
//
//  Created by indianrenters on 14/06/25.
//
import Foundation
import SwiftUI

struct StudentEntryModel: Codable, Identifiable {
    var id: UUID = UUID()
    var name: String
    var dateOfBirth: Date
    var className: Int
    var divsion: String
    var subjectMarks: [Subject: Int]

    var feedback: String?
    
    var age: Int? {
        let ageComponent = Calendar.current.dateComponents([.year], from: dateOfBirth, to: Date())
        return ageComponent.year
    }
}

