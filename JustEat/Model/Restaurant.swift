//
//  Restaurant.swift
//  JustEat
//
//  Created by Philippa Day on 12/02/2021.
//

import Foundation

struct Restaurant: Decodable {
    let name: String?
    let ratingStars: Double?
    let logoURL: String?

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case ratingStars = "RatingStars"
        case logoURL = "LogoUrl"
    }
}


