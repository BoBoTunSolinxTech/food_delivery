//
//  CartDetailTableViewCell.swift
//  FoodDelivery
//
//  Created by BoBo Tun on 16/05/2025.
//

import UIKit

class CartDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var btnMinus: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
