//
//  GetHelpButton.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/10/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

class GetHelpButton: Button {

    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.15) {
                self.alpha = self.isHighlighted ? 0.5 : 1
            }
        }
    }
    
    init() {
        super.init(title: "GET HELP", font: .roundedSystemFont(ofSize: 13, weight: .bold), titleColor: .white, backColor: .mainTint)
        isHidden = true
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 4
    }
}
