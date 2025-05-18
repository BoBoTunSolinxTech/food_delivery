//
//  CResturantViewController.swift
//  FoodDelivery
//
//  Created by BoBo Tun on 08/05/2025.
//

import UIKit

class CResturantViewController: BaseViewController {

    @IBOutlet weak var tblResturant: UITableView!
    @IBOutlet weak var btnFilter: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupTableView()
    }
    
    override func bindData() {
        super.bindData()
        
        btnBack.tapPublisher.sink {
            self.navigationController?.popViewController(animated: true)
        }.store(in: &bindings)
        
        btnFilter.tapPublisher.sink {
            AppScreens.HomeVC.presentSortingVC.show()
        }.store(in: &bindings)
        
        
        
    }
    
    private func setupTableView() {
        tblResturant.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        
        tblResturant.registerForCells(cells: [
                                         ResturantTableViewCell.self])
        self.tblResturant.contentInset = UIEdgeInsets(top: 0,left: 0,bottom: UIScreen.main.bounds.height * 0.1,right: 0)
        tblResturant.backgroundColor = .clear
        tblResturant.separatorStyle = .none
        tblResturant.dataSource = self
        tblResturant.delegate = self
        tblResturant.reloadData()
    }

}

extension CResturantViewController:  UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return getResturantCell(indexPath: indexPath)
    }
    
    private func getResturantCell(indexPath : IndexPath) -> UITableViewCell {
        let cell = tblResturant.dequeReuseCell(type: ResturantTableViewCell.self, indexPath: indexPath)
        return cell
    }
}
