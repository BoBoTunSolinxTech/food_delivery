//
//  CartAddMoreTableViewCell.swift
//  FoodDelivery
//
//  Created by BoBo Tun on 16/05/2025.
//

import UIKit

class CartAddMoreTableViewCell: BaseTableViewCell {

    @IBOutlet weak var btnAddMore: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func setupUI() {
        super.setupUI()
        
        btnAddMore.addBorder(borderWidth: 1, borderColor: .primary_color, bgColor: .white, isRounded: false, cornerRadius: 8)
    }
    
}
