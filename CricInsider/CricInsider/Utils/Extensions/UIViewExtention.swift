//
//  UIViewExtention.swift
//  CricInsider
//
//  Created by Md. Sakibul Alam Utchas on 21/2/23.
//

import Foundation
import UIKit

extension UIView{
    func addShadow(){
        layer.cornerRadius = 8
        layer.shadowColor = UIColor.systemGray3.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 4
        layer.masksToBounds = false
    }
}
