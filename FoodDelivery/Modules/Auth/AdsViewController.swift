//
//  AdsViewController.swift
//  FoodDelivery
//
//  Created by BoBo Tun on 13/05/2025.
//

import UIKit

class AdsViewController: BaseViewController {

    @IBOutlet weak var btnSkip: UIButton!
    var timer: Timer?
    var timeCount = 5
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func setupUI() {
        super.setupUI()
        self.navigationController?.navigationBar.isHidden = true
        setupTimerForResend()
        btnSkip.addRoundCorners(maskedCorners: [.layerMaxXMaxYCorner,.layerMaxXMinYCorner,.layerMaxXMinYCorner,.layerMinXMinYCorner], radius: btnSkip.frame.height/2, isAll: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
          super.viewWillDisappear(animated)
          stopTitleAnimation()
      }
    //Count timer
    private func setupTimerForResend(){
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            self.timeCount -= 1
            
            if self.timeCount > 0 {
                btnSkip.setTitle("Skip (\(self.timeCount))", for: .normal)
            } else {
                AppScreens.AuthVC.navigateToOnboardAnimatedVC.show()
            }
        }
    }
    
    
    func stopTitleAnimation() {
           timer?.invalidate()
           timer = nil
    }
}
