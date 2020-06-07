//
//  UIColor+Extensions.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/6/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

extension UIColor {
    
    static var mainTint: UIColor {
        return UIColor(displayP3Red: 209/255, green: 47/255, blue: 65/255, alpha: 1)
    }
    
    static var label: UIColor {
        return UIColor(displayP3Red: 5/255, green: 12/255, blue: 28/255, alpha: 1)
    }
    
    static var secondaryBlackLabel: UIColor {
        return UIColor(displayP3Red: 5/255, green: 12/255, blue: 28/255, alpha: 0.65)
    }
    
    static var separator: UIColor {
        return UIColor(displayP3Red: 198/255, green: 198/255, blue: 200/255, alpha: 0.7)
    }
}
