//
//  APIHandler.swift
//  AroundEgypt
//
//  Created by Marco on 2024-11-11.
//

import Foundation

class APIHandler {
    static let defaultURL = "aroundegypt.34ml.com"
    
    enum EndPoints {
        case recommendedExperiences
        case recentExperiences
        case likeExperince(id: String)
        var rawValue: String {
            switch self {
            case .recommendedExperiences:
                return "/experiences?filter[recommended]=true"
            case .recentExperiences:
                return "/experiences"
            case .likeExperince(let id):
                return "/experiences/\(id)/like"
            }
        }
    }
    
    enum Method {
        case get
        case post
        var rawValue: String {
            switch self {
            case .get:
                return "GET"
            case .post:
                return "POST"
            }
        }
    }
    
    enum Completions: String{
        case ssl = "https://"
        case api_version = "v2"
    }
    
    static func getExperincesURL(_ endpoint: EndPoints) -> String {
        return "\(Completions.ssl.rawValue)\(defaultURL)/api/\(Completions.api_version.rawValue)\(endpoint.rawValue)"
    }
}
