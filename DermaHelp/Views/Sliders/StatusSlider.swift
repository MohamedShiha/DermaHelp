//
//  StatusSlider.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/9/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

class StatusSlider: UISlider {
    
    override var value: Float {
        didSet {
            setMinimumTrackColor(by: value)
        }
    }
    
    // MARK: Initializers
    
    init() {
        super.init(frame: .zero)
        isUserInteractionEnabled = false
        setThumbImage(UIImage(), for: .normal)
        value = 0.25
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: Appearance
    
    private func setMinimumTrackColor(by value: Float) {
        switch value {
        case 0.0...0.35:
            minimumTrackTintColor = .systemGreen
        case 0.35...0.75:
            minimumTrackTintColor = .systemYellow
        case 0.75...1:
            minimumTrackTintColor = .red
        default:
            break
        }
    }
}
