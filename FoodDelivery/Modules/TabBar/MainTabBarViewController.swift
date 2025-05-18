//
//  MainTabBarViewController.swift
//  FoodDelivery
//
//  Created by BoBo Tun on 14/05/2025.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.tabBar.backgroundColor = .white
        self.delegate = self
        self.definesPresentationContext = true
        self.tabBar.tintColor = .primary_color
        self.tabBar.unselectedItemTintColor =  .dark_gray_color
        
        
        let homeVC = HomeViewController.init(nibName: String(describing: HomeViewController.self), bundle: nil)
        let homeNav = UINavigationController(rootViewController: homeVC)
        
        let cartVC = CartViewController.init(nibName: String(describing: CartViewController.self), bundle: nil)
        let cartNav = UINavigationController(rootViewController: cartVC)

        let orderVC = OrderViewController.init(nibName: String(describing: OrderViewController.self), bundle: nil)
        let orderNav = UINavigationController(rootViewController: orderVC)
        
        let profileVC = ProfileViewController.init(nibName: String(describing: ProfileViewController.self), bundle: nil)
        let profileNav = UINavigationController(rootViewController: profileVC)
        
        /* Create TabBar items */
        
        let homeItem = UITabBarItem(title: "Home" , image: UIImage(named: "ic_home_0"), selectedImage: UIImage(named: "ic_home_1"))
        homeNav.tabBarItem = homeItem
        
        let cartItem = UITabBarItem(title: "Cart" , image: UIImage(named: "ic_cart_0"), selectedImage: UIImage(named: "ic_cart_1"))
        cartNav.tabBarItem = cartItem
        
        let orderItem = UITabBarItem(title: "Order" , image: UIImage(named: "ic_order_0"), selectedImage: UIImage(named: "ic_order_1"))
        orderNav.tabBarItem = orderItem
        
        let profileItem = UITabBarItem(title: "Profile", image: UIImage(named: "ic_profile_0"), selectedImage: UIImage(named: "ic_profile_1") )
        profileNav.tabBarItem = profileItem
        
        let myviewControllers = [homeNav, cartNav, orderNav, profileNav]
        
        self.setViewControllers(myviewControllers, animated: false)
        
        self.view.backgroundColor = .white
        self.tabBar.isTranslucent = false
        self.tabBar.backgroundColor = .white
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }

}

extension MainTabBarViewController: UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
       print("didSelect Tab Bar")
    }
    
    func tabBarController(_ tabBarController: UITabBarController, willBeginCustomizing viewControllers: [UIViewController]) {
        print("willBeginCustomizing")
    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard (tabBarController.viewControllers?.firstIndex(of: viewController)) != nil else {
            return true
        }
        return true
    }

    func tabBarController(_ tabBarController: UITabBarController, didEndCustomizing viewControllers: [UIViewController], changed: Bool) {
        print("didEndCustomizing" , changed)
    }

    func tabBarController(_ tabBarController: UITabBarController, willEndCustomizing viewControllers: [UIViewController], changed: Bool) {
        print("willEndCustomizing" , changed)
    }
}
