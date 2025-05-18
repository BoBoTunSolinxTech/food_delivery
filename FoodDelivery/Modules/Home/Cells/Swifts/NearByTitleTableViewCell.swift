//
//  NearByTitleTableViewCell.swift
//  FoodDelivery
//
//  Created by BoBo Tun on 25/04/2025.
//

import UIKit
protocol NearByTitleTableViewCellDelegate {
    func didTapSorting()
}

class NearByTitleTableViewCell: BaseTableViewCell {
    @IBOutlet weak var btnSort: UIButton!
    
    var delegate: NearByTitleTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func bindData() {
        super.bindData()
        
        btnSort.tapPublisher.sink{
            self.delegate?.didTapSorting()
        }.store(in: &bindings)
    }
    
}
