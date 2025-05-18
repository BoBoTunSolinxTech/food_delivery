//
//  CartTableViewCell.swift
//  FoodDelivery
//
//  Created by BoBo Tun on 16/05/2025.
//

import UIKit
protocol CartTableViewCellDelegate {
    func didTapDeleteCartItem(indexPath: Int)
}

class CartTableViewCell: BaseTableViewCell {

    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var deliDistanceView: UIView!
    @IBOutlet weak var deliStatusView: UIView!
    @IBOutlet weak var deliStatusBgView: UIView!
    @IBOutlet weak var dotView: UIView!
    @IBOutlet weak var bgView: UIView!
    var delegate: CartTableViewCellDelegate?
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
        
        bgView.addBorder(borderWidth: 1, borderColor: .stoke_colorII, bgColor: .white, isRounded: false, cornerRadius: 8)
        
        deliStatusBgView.addBorder(borderWidth: 1, borderColor: .primary_color, bgColor: .clear, isRounded: true, cornerRadius: 0)
    }
    
    override func bindData() {
        super.bindData()
        
        btnDelete.tapPublisher.sink{
            self.delegate?.didTapDeleteCartItem(indexPath: 0)
        }.store(in: &bindings)
    }
    
}
