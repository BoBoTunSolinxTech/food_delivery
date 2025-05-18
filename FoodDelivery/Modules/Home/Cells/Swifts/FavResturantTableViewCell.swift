//
//  FavResturantTableViewCell.swift
//  FoodDelivery
//
//  Created by BoBo Tun on 25/04/2025.
//

import UIKit
protocol FavResturantTableViewCellDelegate {
    func didTapResturantseeAll()
}
class FavResturantTableViewCell: BaseTableViewCell {

    @IBOutlet weak var favResturant: UICollectionView!
    var delegate: FavResturantTableViewCellDelegate?
    @IBOutlet weak var btnSeeAll: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func bindData() {
        super.bindData()
        
        btnSeeAll.tapPublisher.sink{
            self.delegate?.didTapResturantseeAll()
        }.store(in: &bindings)
    }
    private func setupCollectionView() {
        favResturant.registerForCells(cells: [
            FavResturantCollectionViewCell.self])
        favResturant.dataSource = self
        favResturant.delegate = self
        
    }
    
}

extension FavResturantTableViewCell:UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: FavResturantCollectionViewCell.self), for: indexPath) as! FavResturantCollectionViewCell
        return cell
    }
    
    
}
