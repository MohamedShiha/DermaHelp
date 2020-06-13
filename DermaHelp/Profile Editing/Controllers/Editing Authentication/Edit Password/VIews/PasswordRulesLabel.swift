//
//  PasswordRulesLabel.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 6/8/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

class PasswordRulesLabel: Label {

    init(text: String?) {
        super.init(text: text, font: .roundedSystemFont(ofSize: 14, weight: .medium), color: .secondaryBlackLabel)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: Animation
    
    func animateIfMatching(_ isMatching: Bool) {
        UIView.animate(withDuration: 0.3) {
            self.textColor = isMatching ? .mainTint : .secondaryBlackLabel
        }
    }
}
