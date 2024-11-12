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
    var likesNumber: Int
    let recommended: Int
    let isLiked: Int?
    let city: City
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, recommended, city
        case coverPhoto = "cover_photo"
        case viewsNumber = "views_no"
        case likesNumber = "likes_no"
        case isLiked = "is_liked"
    }
    
    static let previewExperience = Experience(id: "7f209d18-36a1-44d5-a0ed-b7eddfad48d6", title: "Abu Simbel Temples", coverPhoto: "", description: "The Abu Simbel temples are two massive rock temples at Abu Simbel, a village in Nubia, southern Egypt, near the border with Sudan. They are situated on the western bank of Lake Nasser, about 230 km southwest of Aswan. The complex is part of the UNESCO World Heritage Site known as the \"Nubian Monuments\", which run from Abu Simbel downriver to Philae.", viewsNumber: 1000, likesNumber: 1000, recommended: 1, isLiked: nil, city: City(name: "Aswan"))
}

struct City: Codable{
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name
    }
}
