//
//  UISeparator.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/6/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

class UISeparator: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .separator
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
