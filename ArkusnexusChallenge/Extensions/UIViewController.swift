//
//  UIViewController.swift
//  ArkusnexusChallenge
//
//  Created by Efrén Pérez Bernabe on 6/10/19.
//  Copyright © 2019 Efrén Pérez Bernabe. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    /// Obtain the height of the top bar view as CGFloat.
    var topBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
}
