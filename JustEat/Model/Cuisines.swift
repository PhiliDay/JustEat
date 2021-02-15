//
//  Cuisines.swift
//  JustEat
//
//  Created by Philippa Day on 15/02/2021.
//

import Foundation

struct Cuisines: Decodable {
    let name: String?

    enum CodingKeys: String, CodingKey {
        case name = "Name"
    }
}
