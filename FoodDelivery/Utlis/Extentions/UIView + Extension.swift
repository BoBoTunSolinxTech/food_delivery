//
//  UIViewExtension.swift
//  Solinx_iOS_Code_Test
//
//  Created by MacBook Pro on 9/27/23.
//

import UIKit

// MARK: - enums
public extension UIView {
//    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
////        let maskPath = UIBezierPath(
////            roundedRect: bounds,
////            byRoundingCorners: corners,
////            cornerRadii: CGSize(width: radius, height: radius))
////
////        let shape = CAShapeLayer()
////        shape.path = maskPath.cgPath
////        layer.mask = shape
//        
//        layer.cornerRadius = radius
//        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//    }
    
    func addRoundCorners(maskedCorners: CACornerMask?, radius: CGFloat, isAll: Bool){
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
        self.layer.maskedCorners = (isAll ? [.layerMaxXMaxYCorner,.layerMaxXMinYCorner,.layerMinXMaxYCorner,.layerMinXMinYCorner] : maskedCorners)!
    }

    func addShadow(ofColor color: UIColor = UIColor(red: 0.07, green: 0.47, blue: 0.57, alpha: 1.0), radius: CGFloat = 3, offset: CGSize = .zero, opacity: Float = 0.5) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
    }
    
    func addBorder(borderWidth: CGFloat,borderColor: UIColor,bgColor: UIColor, isRounded: Bool, cornerRadius: CGFloat){
        layer.backgroundColor = bgColor.cgColor
        layer.cornerRadius = isRounded ? frame.size.height / 2 : cornerRadius
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        layer.masksToBounds = true
    }
}
