//
//  CartViewController.swift
//  FoodDelivery
//
//  Created by BoBo Tun on 14/05/2025.
//

import UIKit

class CartViewController: BaseViewController {

    @IBOutlet weak var tblCart: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func setupUI() {
        super.setupUI()
        self.navigationController?.navigationBar.isHidden = true
        setupTableView()
    }
    
    override func bindData() {
        super.bindData()
    }
    
    override func bindViewModel() {
        super.bindViewModel()
    }
    
    private func setupTableView() {
        tblCart.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        
        tblCart.registerForCells(cells: [
                                         CartTableViewCell.self])
        self.tblCart.contentInset = UIEdgeInsets(top: 0,left: 0,bottom: UIScreen.main.bounds.height * 0.1,right: 0)
        tblCart.backgroundColor = .clear
        tblCart.separatorStyle = .none
        tblCart.dataSource = self
        tblCart.delegate = self
        tblCart.reloadData()
    }

}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return getCartCell(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        AppScreens.CartVC.navigateToCartDetailVC.show()
    }
    
    private func getCartCell(indexPath : IndexPath) -> UITableViewCell {
        let cell = tblCart.dequeReuseCell(type: CartTableViewCell.self, indexPath: indexPath)
        cell.delegate = self
        return cell
    }
    
}

extension CartViewController:CartTableViewCellDelegate{
    func didTapDeleteCartItem(indexPath: Int) {
        AppScreens.CommonVC.showFoodDeliveryAlertVC.show()
    }
    
    
}
