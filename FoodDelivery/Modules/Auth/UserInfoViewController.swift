//
//  UserInfoViewController.swift
//  FoodDelivery
//
//  Created by BoBo Tun on 16/05/2025.
//

import UIKit

class UserInfoViewController: BaseViewController {

    @IBOutlet weak var nameBgView: UIView!
    @IBOutlet weak var phoneBgView: UIView!
    @IBOutlet weak var phoneNumView: UIView!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var btnContinue: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    var isPhone = true
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func setupUI() {
        super.setupUI()
        self.navigationController?.navigationBar.isHidden = true
        btnContinue.addRoundCorners(maskedCorners: nil, radius: 4, isAll: true)
        
        phoneBgView.addBorder(borderWidth: 1, borderColor: .stoke_colorII, bgColor: .white, isRounded: false, cornerRadius: 8)
        
        nameBgView.addBorder(borderWidth: 1, borderColor: .stoke_colorII, bgColor: .white, isRounded: false, cornerRadius: 8)
        
        phoneNumView.isHidden = isPhone
        
    }
    
    override func bindData() {
        super.bindData()
        
        btnBack.tapPublisher.sink{
            self.navigationController?.popViewController(animated: true)
        }.store(in: &bindings)
        
        btnContinue.tapPublisher.sink{ _ in
            AppScreens.AuthVC.navigateToHomeVC.show()
        }.store(in: &bindings)
    }

}
