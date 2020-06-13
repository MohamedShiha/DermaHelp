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
    
    // MARK: Animations
    
    func animateAlpha(_ alpha: CGFloat) {
        UIView.animate(withDuration: 0.25) {
            self.alpha = alpha
        }
    }
    
    func scaleTo(point: CGPoint, animated: Bool = true) {
        if animated {
            UIView.animate(withDuration: 0.3) {
                self.transform = CGAffineTransform.identity.scaledBy(x: point.x, y: point.y)
            }
        } else {
            transform = CGAffineTransform.identity
        }
    }
    
    func scaleToIdentity(animated: Bool = true) {
        if animated {
            UIView.animate(withDuration: 0.3) {
                self.transform = CGAffineTransform.identity
            }
        } else {
            transform = CGAffineTransform.identity
        }
    }
}
