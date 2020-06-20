//
//  GenderSegmentedControl.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/11/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

class GenderSegmentedControl: UISegmentedControl {

    // MARK: Properties
    
    var gender: User.Gender? {
        switch selectedSegmentIndex {
        case 0:
            return .male
        case 1:
            return .female
        default:
            return nil
        }
    }
    
    // MARK: Initializers
    
    init() {
        super.init(items: [String.localized(key: "male"), .localized(key: "female")])
        setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.mainTint], for: .selected)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
