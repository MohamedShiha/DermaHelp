
//
//  GenderSegmentedControl.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/11/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

class GenderSegmentedControl: UISegmentedControl {

    init() {
        super.init(items: ["Male", "Female"])
        selectedSegmentIndex = 0
        setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.mainTint], for: .selected)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
