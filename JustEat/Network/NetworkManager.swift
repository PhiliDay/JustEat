//
//  NetworkManager.swift
//  JustEat
//
//  Created by Philippa Day on 12/02/2021.
//

import Foundation

class NetworkManager {

    func fetchRestaurants(postcode: String, completion: @escaping (Result<[Restaurant], Error>) -> Void) {

        // URL
        let baseURL = URL(string: Constants.baseURL)
        guard var url = baseURL else {
            print("Issue with baseURL: \(#function)")
            return }

        // Query
        url.appendPathComponent("\(postcode)")

        // Request
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        request.httpBody = nil

        // Network Call
        URLSession.shared.dataTask(with: request) { data, _, error -> Void in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            guard let data = data else {
                return
            }
            print("Data: \(data)")

            let jsonDecoder = JSONDecoder()

            do {
                let restaurants = try jsonDecoder.decode(Restaurants.self, from: data)
                let restaurant = restaurants.restaurants
                completion(.success(restaurant))
                print("Success: \(restaurant)")
            } catch {
                print("Failure: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
        }.resume()

    }
}
