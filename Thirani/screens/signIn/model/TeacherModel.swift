//
//  Teacher.swift
//  Thirani
//
//  Created by indianrenters on 25/06/25.
//

import Foundation

struct LoginRequest: Codable {
    var username: String
    var password: String
}

struct LoginResponse: Codable {
    var userId: String
    var token: String
}
