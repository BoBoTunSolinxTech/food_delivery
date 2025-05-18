//
//  CategoryViewController.swift
//  FoodDelivery
//
//  Created by BoBo Tun on 07/05/2025.
//

import UIKit

class CategoryViewController: BaseViewController {

    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var searchBgView: UIView!
    @IBOutlet weak var btnBack: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    override func setupUI() {
        super.setupUI()
        
        searchBgView.addRoundCorners(maskedCorners: [.layerMaxXMaxYCorner,.layerMaxXMinYCorner,.layerMinXMaxYCorner,.layerMinXMinYCorner], radius: 8, isAll: true)
        setupCollectionView()
    }
    
    override func bindData() {
        super.bindData()
        
        btnBack.tapPublisher.sink {
            //AppScreens.HomeVC.backToHomeVC.show()
            self.navigationController?.popViewController(animated: true)
        }.store(in: &bindings)
    }
    
    private func setupCollectionView() {
        categoryCollectionView.registerForCells(cells: [
            CategoryCollectionViewCell.self])
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        
    }

}

extension CategoryViewController: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 11
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CategoryCollectionViewCell.self), for: indexPath) as! CategoryCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        AppScreens.HomeVC.navigateToCResturantVC.show()
    }
    
    
}
