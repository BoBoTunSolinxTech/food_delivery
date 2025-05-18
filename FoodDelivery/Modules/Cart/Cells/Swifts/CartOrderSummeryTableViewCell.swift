//
//  CartOrderSummeryTableViewCell.swift
//  FoodDelivery
//
//  Created by BoBo Tun on 16/05/2025.
//

import UIKit

class CartOrderSummeryTableViewCell: BaseTableViewCell {

    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var shopBgView: UIView!
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
        
        shopBgView.backgroundColor = .button_active_color
    }
}
