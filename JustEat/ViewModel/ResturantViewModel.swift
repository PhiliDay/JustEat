//
//  ResturantViewModel.swift
//  JustEat
//
//  Created by Philippa Day on 27/02/2021.
//

import Foundation

struct RestaurantViewModel {

    let name: String
    let rating: Double
    let typeOfFood: [Cuisines]
    let logoURL: String
    
    init(restaurant: Restaurant) {
        self.name = restaurant.name ?? ""
        self.rating = restaurant.ratingStars ?? 0
        self.typeOfFood = restaurant.typeOfFood ?? []
        self.logoURL = restaurant.logoURL ?? ""
    }
}
