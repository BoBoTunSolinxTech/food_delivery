//
//  BaseTableViewCell.swift
//  FattyCustomer
//
//  Created by BoBo Tun on 03/02/2024.
//

import UIKit
import Combine

class BaseTableViewCell : UITableViewCell {
    var currencySymbol = ""
    var bindings = Set<AnyCancellable>()

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        setupUI()
        bindData()
        setupLanguage()
    }
    
    @objc func reload(){
        setupLanguage()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setupUI() {
//        if let currencyVo = UserDefaultManager.getSelectedCurrency() {
//            currencySymbol = currencyVo.currencySymbol ?? ""
//        } else {
//            currencySymbol = "MMK"
//        }
    }
    
    func bindData() {
        
    }
    
    func setupLanguage(){
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bindData()
    }
    
    func setupTest() {

    }
}
