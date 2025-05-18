//
//  CategoryTableViewCell.swift
//  FoodDelivery
//
//  Created by BoBo Tun on 25/04/2025.
//

import UIKit
protocol CategoryTableViewCellDelegate {
    func didTapCategorySeeAll()
}
class CategoryTableViewCell: BaseTableViewCell {

    @IBOutlet weak var category: UICollectionView!
    @IBOutlet weak var btnSeeAll: UIButton!
    var delegate: CategoryTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupCollectionView() {
        category.registerForCells(cells: [
            CategoryCollectionViewCell.self])
        category.dataSource = self
        category.delegate = self
        
    }
    
    override func bindData() {
        super.bindData()
        
        btnSeeAll.tapPublisher.sink{
            self.delegate?.didTapCategorySeeAll()
        }.store(in: &bindings)
    }
    
}

extension CategoryTableViewCell:UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CategoryCollectionViewCell.self), for: indexPath) as! CategoryCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        AppScreens.HomeVC.navigateToCResturantVC.show()
    }
    
}
