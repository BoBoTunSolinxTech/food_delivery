//
//  CartDetailViewController.swift
//  FoodDelivery
//
//  Created by BoBo Tun on 16/05/2025.
//

import UIKit

class CartDetailViewController: BaseViewController {

    @IBOutlet weak var btnCheckout: UIButton!
    @IBOutlet weak var tblCartList: UITableView!
    @IBOutlet weak var btnBack: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func bindData() {
        super.bindData()
        
        btnBack.tapPublisher.sink{
            self.navigationController?.popViewController(animated: true)
        }.store(in: &bindings)
        
    }
    
    override func setupUI() {
        super.setupUI()
        self.navigationController?.navigationBar.isHidden = true
        setupTableView()
        btnCheckout.addBorder(borderWidth: 1, borderColor: .primary_color, bgColor: .primary_color, isRounded: false, cornerRadius: 8)
    }

    override func bindViewModel() {
        super.bindViewModel()
    }
    
    private func setupTableView() {
        tblCartList.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        
        tblCartList.registerForCells(cells: [
                                         CartDeliveryTableViewCell.self,
                                         CartOrderSummeryTableViewCell.self,
                                         CartAddMoreTableViewCell.self,
                                         CartDetailTableViewCell.self])
        self.tblCartList.contentInset = UIEdgeInsets(top: 0,left: 0,bottom: UIScreen.main.bounds.height * 0.1,right: 0)
        tblCartList.backgroundColor = .clear
        tblCartList.separatorStyle = .none
        tblCartList.dataSource = self
        tblCartList.delegate = self
        tblCartList.reloadData()
    }

}

extension CartDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            return getCartDeliveryCell(indexPath: indexPath)
        case 1:
            return getCartSummeryCell(indexPath: indexPath)
        case 2:
            return getCartAddMoreCell(indexPath: indexPath)
        default:
            return getCartDetailCell(indexPath: indexPath)
        }
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        AppScreens.CartVC.navigateToCartDetailVC.show()
    }
    
    private func getCartDeliveryCell(indexPath : IndexPath) -> UITableViewCell {
        let cell = tblCartList.dequeReuseCell(type: CartDeliveryTableViewCell.self, indexPath: indexPath)
        return cell
    }
    
    private func getCartSummeryCell(indexPath : IndexPath) -> UITableViewCell {
        let cell = tblCartList.dequeReuseCell(type: CartOrderSummeryTableViewCell.self, indexPath: indexPath)
        return cell
    }
    
    private func getCartAddMoreCell(indexPath : IndexPath) -> UITableViewCell {
        let cell = tblCartList.dequeReuseCell(type: CartAddMoreTableViewCell.self, indexPath: indexPath)
        return cell
    }
    
    private func getCartDetailCell(indexPath : IndexPath) -> UITableViewCell {
        let cell = tblCartList.dequeReuseCell(type: CartDetailTableViewCell.self, indexPath: indexPath)
        return cell
    }
    
}
