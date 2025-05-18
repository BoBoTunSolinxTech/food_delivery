//
//  BaseCollectionViewCell.swift
//  FattyCustomer
//
//  Created by BoBo Tun on 15/02/2024.
//

import UIKit
import Combine
class BaseCollectionViewCell: UICollectionViewCell {
    var bindings = Set<AnyCancellable>()
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bindData()
        setupUI()
    }
   
    
    func bindData() {
        
    }
    
    func setupUI() {
       
    }
    
}
