//
//  AppScreens.swift
//  FattyCustomer
//
//  Created by BoBo Tun on 02/02/2024.
//
import Foundation
import UIKit
import FittedSheets

struct AppScreens {
    static var shared = AppScreens()
    var currentVC : UIViewController?
    var previousVC : UIViewController?
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    enum CommonVC {
        case showFoodDeliveryAlertVC
        func show () {
            switch self {
            case .showFoodDeliveryAlertVC:
                AppScreens.shared.showFoodDeliveryAlertVC()
            }
        }
    }
    
    enum AuthVC {
        case navigateToAdsVC
        case navigateToOnboardAnimatedVC
        case navigateToOnboardingVC
        case navigateToHomeVC
        case navigateToLoginVC
        case navigateToOTPVC(_ isPhone : Bool,_ parseString : String)
        case navigateToUserInfoVC(_ isPhone : Bool)
        func show () {
            switch self {
            case .navigateToAdsVC:
                AppScreens.shared.navigateToAdsVC()
            case .navigateToOnboardAnimatedVC:
                AppScreens.shared.navigateToOnboardAnimatedVC()
            case .navigateToOnboardingVC:
                AppScreens.shared.navigateToOnboardingVC()
            case .navigateToHomeVC:
                AppScreens.shared.navigateToMainTabBarVC()
            case .navigateToLoginVC:
                AppScreens.shared.navigateToLoginVC()
            case .navigateToOTPVC(let isPhone, let parseString):
                AppScreens.shared.navigateToOTPVC(isPhone: isPhone, parseString: parseString)
            case .navigateToUserInfoVC(let isPhone):
                AppScreens.shared.navigateToUserInfoVC(isPhone: isPhone)
            }
        }
    }
    
    enum HomeVC {
        
        case navigateToCategoryVC
        case navigateToCResturantVC
        case navigateToResturantListVC
        case presentSortingVC
        func show () {
            switch self {
            case .navigateToCategoryVC:
                AppScreens.shared.navigateToCategoryVC()
            case .navigateToCResturantVC:
                AppScreens.shared.navigateToCResturantVC()
            case .navigateToResturantListVC:
                AppScreens.shared.navigateToResturantListVC()
            case .presentSortingVC:
                AppScreens.shared.presentSortingVC()
            }
        }
        
    }
    
    enum CartVC {
        case navigateToCartDetailVC
        func show() {
            switch self {
            case .navigateToCartDetailVC:
                AppScreens.shared.navigateToCartDetailVC()
            }
        }
    }
    
    
}

extension AppScreens {
    ///CommonVC
    private func showFoodDeliveryAlertVC(){
        let vc = FoodDeliveryAlertViewController.init()
        vc.modalPresentationStyle = .overFullScreen
        currentVC?.present(vc, animated: true,completion: nil)
    }
    ///AuthVC
    private func navigateToAdsVC() {
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let viewController = AdsViewController.init()
        let navigation = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
        
    }
    private func navigateToOnboardAnimatedVC(){
        let vc = OnboardAnimatedViewController.init()
        currentVC?.navigationController?.pushViewController(vc, animated: true)

    }
    
    private func navigateToOnboardingVC(){
        let vc = OnboardingViewController.init()
        currentVC?.navigationController?.pushViewController(vc, animated: true)

    }
    private func navigateToMainTabBarVC() {
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let initialViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: MainTabBarViewController.self))
        window!.rootViewController = initialViewController
        window!.makeKeyAndVisible()
    }
    private func navigateToLoginVC(){
        let vc = LoginViewController.init()
        currentVC?.navigationController?.pushViewController(vc, animated: true)

    }
    private func navigateToOTPVC(isPhone: Bool,parseString : String){
        let vc = OTPViewController.init()
        vc.isPhone = isPhone
        vc.parseString = parseString
        currentVC?.navigationController?.pushViewController(vc, animated: true)

    }
    
    private func navigateToUserInfoVC(isPhone: Bool){
        let vc = UserInfoViewController.init()
        vc.isPhone = isPhone
        currentVC?.navigationController?.pushViewController(vc, animated: true)
    }
    
    ///HomeVC
    private func navigateToCategoryVC(){
        let vc = CategoryViewController.init()
        currentVC?.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func navigateToCResturantVC(){
        let vc = CResturantViewController.init()
        currentVC?.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func navigateToResturantListVC(){
        let vc = ResturantListViewController.init()
        currentVC?.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func presentSortingVC(){
        let vc = SortingViewController.init()
        let sheetVC = SheetViewController(controller: vc, sizes: [  .percent(0.48)] )
        let previousDidDismiss = sheetVC.didDismiss
        sheetVC.didDismiss = {
            print("did dismiss")
            previousDidDismiss?($0)
        }
        
        let previousShouldDismiss = sheetVC.shouldDismiss
        sheetVC.shouldDismiss = {
            print("should dismiss")
            return previousShouldDismiss?($0) ?? true
        }
        currentVC?.present(sheetVC, animated: true,completion: nil)
    }
    
    /// CartVC
    private func navigateToCartDetailVC(){
        let vc = CartDetailViewController.init()
        vc.hidesBottomBarWhenPushed = true
        currentVC?.navigationController?.pushViewController(vc, animated: true)
    }
}


