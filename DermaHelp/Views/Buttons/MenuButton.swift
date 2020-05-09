//
//  MenuButton.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/9/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

class MenuButton: Button {

    // MARK: Properties
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.2) {
                self.backgroundColor = UIColor(displayP3Red: 0.8, green: 0.8, blue: 0.8, alpha: self.isHighlighted ? 1 : 0)
            }
        }
    }
    
    // MARK: Initializers
    
    init() {
        super.init(image: UIImage(named: "Menu"), backColor: .clear)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }
}
