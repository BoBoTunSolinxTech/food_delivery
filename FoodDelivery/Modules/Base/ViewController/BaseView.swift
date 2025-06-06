//
//  BaseView.swift
//  FattyCustomer
//
//  Created by BoBo Tun on 03/02/2024.
//

import Foundation
import Combine
import CombineCocoa

class BaseView : UIView {
    
    var view: UIView!
    var bindings = Set<AnyCancellable>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        bindData()
        setupLanguage()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
        bindData()
        setupLanguage()
    }
    
    @objc func reload(){
        setupLanguage()
    }

    func setupUI() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView! {
        return UINib(nibName: String(describing: type(of: self)), bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView ?? UIView(frame: CGRect.zero)
    }
    
    func bindData() {
        
    }

    func setupLanguage() {
        
    }
    
    func setupTest() {
        
    }
}
