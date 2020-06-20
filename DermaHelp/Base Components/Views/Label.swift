//
//  Label.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/6/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

protocol LocalizableControl {
    var localizingKey: String { get set }
}

class Label: UILabel, LocalizableControl {
    
    override var text: String? {
        didSet {
            if translatesAutoresizingMaskIntoConstraints {
                sizeToFit()
            }
        }
    }
    var padding: UIEdgeInsets
    var localizingKey = "" {
        didSet {
            text = .localized(key: localizingKey)
        }
    }
    
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
        if effectiveUserInterfaceLayoutDirection == .rightToLeft {
            self.padding = UIEdgeInsets(top: padding.top, left: padding.right, bottom: padding.bottom, right: padding.left)
        } else {
            self.padding = padding
        }
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
