//
//  SortingViewController.swift
//  FoodDelivery
//
//  Created by BoBo Tun on 14/05/2025.
//

import UIKit
import RxSwift
import Combine

class SortingViewController: UIViewController {

    @IBOutlet weak var btnApply: UIButton!
    @IBOutlet weak var btnReset: UIButton!
    @IBOutlet weak var tblSorting: UITableView!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    var sortingList = ["Discount First (Default)","Nearest","Highest Rating","Popular"]
    var selectedSortingIndex: Int = 0
    var baseViewModel = BaseViewModel()
    var disposableBag = DisposeBag()
    var bindings = Set<AnyCancellable>()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
    }

    func setupUI() {
        setupTableView()
        btnReset.addBorder(borderWidth: 1, borderColor: .primary_color, bgColor: .white, isRounded: false, cornerRadius: 8)
        btnApply.addBorder(borderWidth: 1, borderColor: .primary_color, bgColor: .primary_color, isRounded: false, cornerRadius: 8)
        btnApply.setTitleColor(.white, for: .normal)
        btnReset.setTitleColor(.primary_color, for: .normal)
        
        btnApply.setTitle("Apply", for: .normal)
        btnReset.setTitle("Reset", for: .normal)
        
        updateResetButton(isActive: false)
        
        bindData()
    }

    func updateResetButton(isActive:Bool){
        self.btnReset.alpha = isActive ? 1 : 0.4
        self.btnReset.isEnabled = isActive
    }
    func bindData() {
        btnClose.tapPublisher.sink{
            self.dismiss(animated: true)
        }.store(in: &bindings)
        
        btnReset.tapPublisher.sink{
            self.selectedSortingIndex = 0
            self.tblSorting.reloadData()
        }.store(in: &bindings)
        
        btnApply.tapPublisher.sink{
            self.dismiss(animated: true)
        }.store(in: &bindings)
    }
    
    private func setupTableView() {
        tblSorting.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        
        tblSorting.registerForCells(cells: [
                                         SortingTableViewCell.self])
        self.tblSorting.contentInset = UIEdgeInsets(top: 0,left: 0,bottom: UIScreen.main.bounds.height * 0.1,right: 0)
        tblSorting.backgroundColor = .clear
        tblSorting.separatorStyle = .none
        tblSorting.dataSource = self
        tblSorting.delegate = self
        tblSorting.reloadData()
    }
}

extension SortingViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return getSortingCell(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedSortingIndex = indexPath.row
        if indexPath.row == 0 {
            self.updateResetButton(isActive: false)
        }else{
            self.updateResetButton(isActive: true)
        }
        self.tblSorting.reloadData()
    }
    
    private func getSortingCell(indexPath : IndexPath) -> UITableViewCell {
        let cell = tblSorting.dequeReuseCell(type: SortingTableViewCell.self, indexPath: indexPath)
        cell.lblTitle.text = sortingList[indexPath.row]
        if selectedSortingIndex == indexPath.row {
            cell.bgView.addBorder(borderWidth: 1, borderColor: .primary_color, bgColor: .clear, isRounded: false, cornerRadius: 8)
            cell.btnRadio.setImage(UIImage(named: "ic_radio_on"), for: .normal)
        }else{
            cell.bgView.addBorder(borderWidth: 1, borderColor: .stoke_colorII, bgColor: .clear, isRounded: false, cornerRadius: 8)
            cell.btnRadio.setImage(UIImage(named: "ic_radio_off"), for: .normal)
        }
        
        return cell
    }
}
