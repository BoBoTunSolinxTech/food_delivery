//
//  OrderTypeTableViewCell.swift
//  FoodDelivery
//
//  Created by BoBo Tun on 24/04/2025.
//

import UIKit

class OrderTypeTableViewCell: BaseTableViewCell {

    @IBOutlet weak var btnPicket: UIButton!
    @IBOutlet weak var btnDelivery: UIButton!
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
        
        btnDelivery.setTitleColor(.white, for: .normal)
        btnDelivery.addBorder(borderWidth: 2, borderColor: .primary_color, bgColor: .primary_color, isRounded: true, cornerRadius: 0)
        
        btnPicket.setTitleColor(.text_light_color, for: .normal)
        btnPicket.addBorder(borderWidth: 2, borderColor: .stoke_color, bgColor: .white, isRounded: true, cornerRadius: 0)
        
    }
}
