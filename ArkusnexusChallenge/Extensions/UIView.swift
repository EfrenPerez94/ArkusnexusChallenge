//
//  UIView.swift
//  ArkusnexusChallenge
//
//  Created by Efrén Pérez Bernabe on 6/9/19.
//  Copyright © 2019 Efrén Pérez Bernabe. All rights reserved.
//

import UIKit

extension UIView {
    /// Adds an array of subviews.
    /// - Parameter subviews: Views to add as subviews.
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach { (subview) in
            subview.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(subview)
        }
    }
}
