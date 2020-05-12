//
//  UIView+Extensions.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/10/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

extension UIView {
    
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    var parentTabBarController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let tabBarController = parentResponder as? UITabBarController {
                return tabBarController
            }
        }
        return nil
    }
    
    func animateAlpha(_ alpha: CGFloat) {
        UIView.animate(withDuration: 0.25) {
            self.alpha = alpha
        }
    }
}
