//
//  UITableView + Extension.swift
//  FattyCustomer
//
//  Created by Phyo Kyaw Swar on 23/11/2021.
//

import Foundation
import UIKit

extension UITableView {
    
    func registerForCells<T>(cells : T...) {
        cells.forEach { (cell) in
            register(UINib(nibName: String(describing: cell), bundle: nil), forCellReuseIdentifier: String(describing: cell))
        }
    }
    
    func registerForCells<T>(cells : [T]) {
        cells.forEach { (cell) in
            register(UINib(nibName: String(describing: cell), bundle: nil), forCellReuseIdentifier: String(describing: cell))
        }
    }
    
    func dequeReuseCell<T>(type : T.Type, indexPath : IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: String(describing: type), for: indexPath) as! T
    }
    
    func reloadWithAnimation(view: UIView, animations: UIView.AnimationOptions = [], duration: TimeInterval, onComplete: ((Bool)->Void)? = nil) {
        UIView.transition(with: view, duration: duration, options: animations, animations: {
            self.reloadData()
        }, completion: onComplete)
    }
    
    func reloadData(completion:@escaping ()->()) {
        UIView.animate(withDuration: 0, animations: { self.reloadData() })
            { _ in completion() }
    }
    
    func reloadToOffset() {
        let tableView = self
        let contentOffset = tableView.contentOffset
        UIView.performWithoutAnimation {
            tableView.reloadData()
            tableView.setContentOffset(contentOffset, animated: false)
        }
    }
    
    func scrollTableViewToBottom(animated: Bool) {
        guard let dataSource = dataSource else { return }
        
        var lastSectionWithAtLeasOneElements = (dataSource.numberOfSections?(in: self) ?? 1) - 1
        
        while dataSource.tableView(self, numberOfRowsInSection: lastSectionWithAtLeasOneElements) < 1 {
            lastSectionWithAtLeasOneElements -= 1
        }
        
        let lastRow = dataSource.tableView(self, numberOfRowsInSection: lastSectionWithAtLeasOneElements) - 1
        
        guard lastSectionWithAtLeasOneElements > -1 && lastRow > -1 else { return }
        
        let bottomIndex = IndexPath(item: lastRow, section: lastSectionWithAtLeasOneElements)
        scrollToRow(at: bottomIndex, at: .bottom, animated: animated)
    }
}

