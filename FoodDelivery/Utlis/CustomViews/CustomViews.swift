//
//  CustomViews.swift
//  Solinx_iOS_Code_Test
//
//  Created by MacBook Pro on 9/27/23.
//


import UIKit

protocol ErrorHandlerDelegate: AnyObject {
    func didTapRetry()
}

class ErrorHandlerView: BaseView {
    
    @IBOutlet weak var imgError: UIImageView!
    @IBOutlet weak var lblErrorTitle: UILabel!
    @IBOutlet weak var lblErrorDesc: UILabel!
    @IBOutlet weak var btnRetry: RoundedCornerUIButton!
    @IBOutlet weak var widthConstraintForTryAgain: NSLayoutConstraint!
    
    static let shared = ErrorHandlerView()
    
    weak var delegate : ErrorHandlerDelegate?
    
    override func setupUI() {
        super.setupUI()
        lblErrorTitle.font = UIFont.boldSystemFont(ofSize: 16)
        lblErrorDesc.font = UIFont.systemFont(ofSize: 14)
        lblErrorTitle.textColor = .black
        lblErrorDesc.textColor = .black
        btnRetry.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btnRetry.titleLabel?.textColor = .black
    }

    override func setupLanguage() {
        super.setupLanguage()
        btnRetry.setTitle("Try Again", for: .normal)
    }
    
    func setupView(isShow : Bool , isServerError : Bool = false) {
        widthConstraintForTryAgain.constant = "Try Again".size(withAttributes: [.font: UIFont.boldSystemFont(ofSize: 16)]).width + 20
        var error_image : UIImage?
        var error_title : String?
        var error_desc : String?
        if !InternetConnectionManager.isInternetAvailable() {
            error_image = UIImage(named: "ic_no_internet")
            error_title = "No Internet Connection"
            error_desc = "Please check your internet connection and try again"
            self.btnRetry.isHidden = false
            self.btnRetry.isUserInteractionEnabled = true
        } else {
            if isServerError {
                error_image = UIImage(named: "ic_no_server")
                error_title = "Under Maintainance"
                error_desc = "The page you looking for currently under maintainance and will be back soon"
                self.btnRetry.isHidden = false
                self.btnRetry.isUserInteractionEnabled = true
            } else {
                error_image = UIImage(named: "ic_no_data")
                error_title = ""
                error_desc = "No Data"
                self.btnRetry.isHidden = true
                self.btnRetry.isUserInteractionEnabled = false
            }
        }
        imgError.image = error_image
        lblErrorTitle.text = error_title
        lblErrorDesc.text = error_desc
    }

    func removeView() {
        removeFromSuperview()
    }
    
    override func bindData() {
        super.bindData()
        btnRetry.tapPublisher.sink {
            self.delegate?.didTapRetry()
            self.removeView()
        }.store(in: &bindings)
    }
}




