//
//  Button.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/6/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

class Button: UIButton {

    // MARK: Properties
    
    override var isHighlighted: Bool {
        didSet {
            animateAlpha(self.isHighlighted ? 0.5 : 1)
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            animateAlpha(self.isEnabled ? 1 : 0.5)
        }
    }
    
    typealias buttonHandler = (Button) -> ()
    
    var didTapButton: buttonHandler? {
        didSet {
            if didTapButton != nil {
                addTarget(self, action: #selector(didTapButton(sender:)), for: .touchUpInside)
            } else {
                removeTarget(self, action: #selector(didTapButton(sender:)), for: .touchUpInside)
            }
        }
    }

    
    // MARK: Initializers
    
    init(title: String?, font: UIFont = .roundedSystemFont(ofSize: 16, weight: .regular), titleColor: UIColor? = .mainTint, backColor: UIColor = .clear) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        titleLabel?.font = font
        setTitleColor(titleColor, for: .normal)
        backgroundColor = backColor
        sizeToFit()
    }
    
    init(image: UIImage?, configuration: UIImage.SymbolConfiguration = .unspecified, tint: UIColor? = .mainTint, backColor: UIColor = .systemFill) {
        super.init(frame: .zero)
        setImage(image, for: .normal)
        adjustsImageWhenHighlighted = false
        setPreferredSymbolConfiguration(configuration, forImageIn: .normal)
        tintColor = tint
        backgroundColor = backColor
        sizeToFit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 8
    }
    
    // MARK: Action with a closure

    @objc
    private func didTapButton(sender: UIButton) {
        if let handler = didTapButton {
            handler(self)
        }
    }
}
