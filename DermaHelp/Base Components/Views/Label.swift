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
    var padding: UIEdgeInsets
    
    init(text: String? = nil,
         font: UIFont = .roundedSystemFont(ofSize: UIFont.labelFontSize, weight: .regular),
         color: UIColor! = .label, alignment: NSTextAlignment = .natural, numberOfLines: Int = 1,
         padding: UIEdgeInsets = .zero) {
        self.padding = padding
        super.init(frame: .zero)
        self.text = text
        self.font = font
        self.textColor = color
        self.textAlignment = alignment
        self.numberOfLines = numberOfLines
    }
    
    required init?(coder: NSCoder) {
        padding = .zero
        super.init(coder: coder)
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
    // MARK: Animations
    
    func animateTextColor(to color:UIColor) {
        UIView.transition(with: self, duration: 0.25, options: .transitionCrossDissolve, animations: {
            self.textColor = color
        }, completion: nil)
    }
}
