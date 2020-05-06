//
//  UIFont+Extensions.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/4/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

extension UIFont {
    
    class func roundedSystemFont(ofSize fontSize: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
        
        let descriptor = UIFont.systemFont(ofSize: fontSize, weight: weight).fontDescriptor
        guard let roundedDescriptor = descriptor.withDesign(.rounded) else {
            return UIFont.systemFont(ofSize: fontSize, weight: weight)
        }
        return UIFont(descriptor: roundedDescriptor, size: fontSize)
    }
}
