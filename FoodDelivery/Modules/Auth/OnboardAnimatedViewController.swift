//
//  OnboardAnimatedViewController.swift
//  FoodDelivery
//
//  Created by BoBo Tun on 13/05/2025.
//

import UIKit

class OnboardAnimatedViewController: BaseViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var animatedView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    let items = ["Delicious Meals from Top Restaurants", "Lightning-Fast Delivery at Your Doorstep", "Track Your Order in Real-Time", "Chat with Your Rider Instantly", "Simple, Secure, and Seamless Ordering"]
    var currentRow = 0
    var timer: Timer?
    var lastActiveIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.translatesAutoresizingMaskIntoConstraints = false


        lastActiveIndex = currentRow
        pickerView.selectRow(currentRow, inComponent: 0, animated: false)

        startAutoScroll()
    }
    override func setupUI() {
        super.setupUI()
        self.navigationController?.navigationBar.isHidden = true
        self.removeSelectionHighlight()
       
    }
    
    func removeSelectionHighlight() {
        for subview in pickerView.subviews {
            // The selection indicator lines are usually thin (<= 1 or 2 points height)
            if subview.bounds.height <= 2 {
                subview.isHidden = true
            }
            // Also try to hide the selection background (usually has alpha)
            if subview.backgroundColor?.cgColor.alpha ?? 0 > 0 {
                subview.backgroundColor = .clear
            }
        }
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50 // change 50 to whatever height you want
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = items[row]

        if row >= currentRow {
            label.textColor = .black // Show current and future rows
        } else {
            label.textColor = .clear // Hide previous rows
        }

        return label
    }

    func startAutoScroll() {
        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }

            self.currentRow += 1

            if self.currentRow >= self.items.count {
                self.timer?.invalidate()
                self.timer = nil
                print("✅ Auto-scroll finished. Last active index: \(self.lastActiveIndex ?? -1)")
                AppScreens.AuthVC.navigateToOnboardingVC.show()
                return
            }

            self.lastActiveIndex = self.currentRow
            self.pickerView.selectRow(self.currentRow, inComponent: 0, animated: true)
            self.pickerView.reloadAllComponents()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
    }
}
