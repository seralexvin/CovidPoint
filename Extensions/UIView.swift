//
//  Extension.swift
//  c
//
//  Created by Servin Asanov on 10.01.2022.
//
import Foundation
import UIKit


extension  UIView {
    func addShadow() {
        self.layer.shadowColor = UIColor(red: 0.658, green: 0.658, blue: 0.658, alpha: 0.24).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 9
        self.layer.shadowOffset = CGSize(width: 0, height: 4.0)
    }
}
