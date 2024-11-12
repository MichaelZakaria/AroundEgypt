//
//  Experience.swift
//  AroundEgypt
//
//  Created by Marco on 2024-11-11.
//

import Foundation
import UIKit

struct ExperiencesResponse: Codable {
    let data: [Experience]
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}

struct Experience: Codable{
    let id: String
    let title: String
    let coverPhoto: String
    let description: String
    let viewsNumber: Int
    let likesNumber: Int
    let recommended: Int
    let isLiked: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, recommended
        case coverPhoto = "cover_photo"
        case viewsNumber = "views_no"
        case likesNumber = "likes_no"
        case isLiked = "is_liked"
    }
}
