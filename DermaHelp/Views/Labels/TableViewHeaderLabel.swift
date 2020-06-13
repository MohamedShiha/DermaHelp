//
//  TableViewHeaderLabel.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 6/7/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

class SectionHeaderLabel: Label {

    init(text: String?) {
        super.init(text: text?.capitalized, font: .roundedSystemFont(ofSize: 13, weight: .semibold), color: .mainTint)
        backgroundColor = .secondarySystemBackground
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        super.drawText(in: rect.inset(by: insets))
    }
}
