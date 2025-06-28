//
//  enum.swift
//  Thirani
//
//  Created by indianrenters on 15/06/25.
//

import Foundation

enum Subject: String, CaseIterable, Codable, Hashable {
    case maths, english, marathi, science, history, geography, hindi, sanskrit

    var totalMarks: Int {
        if self == .history || self == .geography || self == .sanskrit{
            return 50
        } else {
            return 100
        }
    }

    func percentage(for marks: Int) -> Double {
        return (Double(marks) / Double(totalMarks)) * 100
    }

    func grade(for marks: Int) -> String {
        let percent = percentage(for: marks)
        switch percent {
        case 90...100: return "A+"
        case 80..<90: return "A"
        case 70..<80: return "B"
        case 60..<70: return "C"
        case 50..<60: return "D"
        default: return "F"
        }
    }
}

enum SchoolClass: Int, CaseIterable, Hashable {
    case class1 = 1, class2 = 2, class3 = 3, class4 = 4, class5 = 5, class6 = 6, class7 = 7, class8 = 8, class9 = 9, class10 = 10
}

enum Division: String, CaseIterable, Hashable {
    case a, b, c, d
}
