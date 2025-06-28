//
//  Endpoint.swift
//  Thirani
//
//  Created by indianrenters on 16/06/25.
//

import Foundation

enum HttpMEthods: String{
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol EndpointType{
    var baseURL: String { get }
    var path: String { get }
    var method: HttpMEthods { get }
    var headers: [String: String] { get }
    var url: URL { get }
}

enum Endpoint {
    case getAuthToken
    case postStudentEntry
    case getStudentReport
    case getProfileData
}

extension Endpoint: EndpointType{
    var baseURL: String {
        return "https://api.edmodo.com"
    }
    
    var path: String {
        switch self{
        case .getAuthToken: return "/oauth/token"
        case .getProfileData: return "/profile/data"
        case .getStudentReport: return "/student/report"
        case .postStudentEntry: return "/student/entry"
        }
    }
    
    var method: HttpMEthods{
        switch self{
        case .getAuthToken, .getProfileData, .getStudentReport, .postStudentEntry:
            return .post
        }
    }
    
    var headers: [String: String] {
        var accessToken: String = ""
        var header: [String: String] = [:]
        header["Content-Type"] = "application/json"
        header["accept"] = "application/json, text/plain, */*"
        
        header["Authorization"] = "Bearer \(accessToken)"
        return header
    }
    
    var url: URL{
        return URL(string: "\(baseURL)\(path)")!
    }
}
