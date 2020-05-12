//
//  ProfileLabel.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/11/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

class ProfileLabel: Label {

    init(text: String? = nil, font: UIFont = .roundedSystemFont(ofSize: UIFont.labelFontSize, weight: .medium), color: UIColor! = .label) {
        super.init(text: text, font: font, color: color)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
