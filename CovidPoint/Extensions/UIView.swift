//
//  File.swift
//  CovidPoint
//
//  Created by Servin Asanov on 28.12.2021.
//

import UIKit

extension UIView {
    func addShadow(color: UIColor) {
        self.layer.shadowRadius = 20
        self.layer.shadowOpacity = 1
        self.layer.shadowColor = color.cgColor
    }
    
    func cornerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}
