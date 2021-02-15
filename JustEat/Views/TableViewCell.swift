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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
