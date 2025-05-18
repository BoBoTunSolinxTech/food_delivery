//
//  SplashViewController.swift
//  MyHome
//
//  Created by BoBo Tun on 13/01/2025.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
            AppScreens.AuthVC.navigateToAdsVC.show()
        }
    }

}
