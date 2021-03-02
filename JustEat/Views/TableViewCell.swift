//
//  TableViewCell.swift
//  JustEat
//
//  Created by Philippa Day on 13/02/2021.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var typeOfFood: UILabel!

    var restaurantViewModel: RestaurantViewModel! {
        didSet {
            setName()
            setRating()
            setTypeOfFood()
            setLogo()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setTypeOfFood() {
        guard let listOfFood = restaurantViewModel?.typeOfFood else {
            return
        }
        var foodText = ""
        for food in listOfFood {
            guard let name = food.name else {
                return
            }
            foodText.append(" \(name) ")
        }
        typeOfFood.text = "\(foodText) "
    }

    func setLogo() {
        let url = URL(string: restaurantViewModel.logoURL)
        if let url = url {
            let data = try? Data(contentsOf: url)
            if let data = data {
                logo.image = UIImage(data: data)
            }
        }
    }

    func setRating() {
        if let ratingStars = restaurantViewModel?.rating {
            let ratingText = String(format: "%.1f", ratingStars)
            rating.text = "Rating: \(ratingText)"
        }
    }

    func setName() {
        if let name = restaurantViewModel?.name {
            restaurantName.text = "\(name)"
        }
    }
}


