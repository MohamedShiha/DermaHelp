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
    
    static var secondaryLightBackground: UIColor {
        return UIColor(displayP3Red: 239/255, green: 239/255, blue: 244/255, alpha: 1)
    }
    
    static var lightFill: UIColor {
        return UIColor(displayP3Red: 120/255, green: 120/255, blue: 128/255, alpha: 0.2)
    }
    
    static var label: UIColor {
        return UIColor(displayP3Red: 5/255, green: 12/255, blue: 28/255, alpha: 1)
    }
    
    static var secondaryBlackLabel: UIColor {
        return UIColor(displayP3Red: 5/255, green: 12/255, blue: 28/255, alpha: 0.65)
//        return UIColor(displayP3Red: 60/255, green: 60/255, blue: 67/255, alpha: 0.6)
    }
    
    static var separator: UIColor {
        return UIColor(displayP3Red: 198/255, green: 198/255, blue: 200/255, alpha: 0.7)
    }
    
    static func black(_ black: CGFloat, alpha a: CGFloat) -> UIColor {
        return UIColor(displayP3Red: black, green: black, blue: black, alpha: a)
    }
}
