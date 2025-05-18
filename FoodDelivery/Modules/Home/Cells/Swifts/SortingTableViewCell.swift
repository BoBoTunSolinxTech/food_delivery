//
//  SortingTableViewCell.swift
//  FoodDelivery
//
//  Created by BoBo Tun on 15/05/2025.
//

import UIKit

class SortingTableViewCell: BaseTableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnRadio: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
