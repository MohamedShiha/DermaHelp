//
//  Label.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/6/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

class Label: UILabel {
    
    override var text: String? {
        didSet {
            if translatesAutoresizingMaskIntoConstraints {
                sizeToFit()
            }
        }
    }
    
    init(text: String? = nil, font: UIFont! = .roundedSystemFont(ofSize: UIFont.labelFontSize, weight: .regular), color: UIColor! = .label, alignment: NSTextAlignment = .natural, numberOfLines: Int = 1) {
        super.init(frame: .zero)
        self.text = text
        self.font = font
        self.textColor = color
        self.textAlignment = alignment
        self.numberOfLines = numberOfLines
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
