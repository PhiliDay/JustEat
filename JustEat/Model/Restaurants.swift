//
//  Restaurants.swift
//  JustEat
//
//  Created by Philippa Day on 12/02/2021.
//

import Foundation

struct Restaurants: Decodable {
    let restaurants: [Restaurant]

    enum CodingKeys: String, CodingKey {
        case restaurants = "Restaurants"
    }
}
