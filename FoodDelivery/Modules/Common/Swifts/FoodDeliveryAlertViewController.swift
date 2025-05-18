//
//  FoodDeliveryAlertViewController.swift
//  FoodDelivery
//
//  Created by BoBo Tun on 16/05/2025.
//

import UIKit
import RxSwift
import Combine

class FoodDeliveryAlertViewController: UIViewController {

    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var alertBgView: UIView!
    @IBOutlet weak var btnRemove: UIButton!
    @IBOutlet weak var btnCancle: UIButton!
    @IBOutlet weak var lblDespriction: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imageBgView: UIView!
    var baseViewModel = BaseViewModel()
    var disposableBag = DisposeBag()
    var bindings = Set<AnyCancellable>()
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        // Do any additional setup after loading the view.
        
    }

     func setupUI() {
        
        imageBgView.addBorder(borderWidth: 1, borderColor: .primary_color, bgColor: .white, isRounded: true, cornerRadius: 0)
        alertBgView.addBorder(borderWidth: 0, borderColor: .clear, bgColor: .white, isRounded: false, cornerRadius: 12)
        
        btnCancle.addBorder(borderWidth: 1, borderColor: .button_active_color, bgColor: .button_active_color, isRounded: false, cornerRadius: 8)
        
        btnRemove.addBorder(borderWidth: 1, borderColor: .primary_color, bgColor: .primary_color, isRounded: false, cornerRadius: 8)
         
         bindData()
    }
    
    func bindData() {
        btnRemove.tapPublisher.sink{
            self.dismiss(animated: true)
        }.store(in: &bindings)
        
        btnCancle.tapPublisher.sink{
            self.dismiss(animated: true)
        }.store(in: &bindings)
    }

}
