//
//  StatusScaleView.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/9/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

class StatusScaleView: UIView, LayoutController {
    
    // MARK: Views
    
    private let label = Label(font: .roundedSystemFont(ofSize: UIFont.labelFontSize, weight: .medium))
    private let scaleSlider = StatusSlider()
    
    // MARK: Properties
    
    var rate: Float = 0 {
        didSet {
            rate = rate > 1.0 ? rate / 100 : rate
            rate = rate < 0 ? abs(rate) : rate
            scaleSlider.value = rate
        }
    }
    
    // MARK: Initializers
    
    init(metricsLabel: String) {
        super.init(frame: .zero)
        label.text = metricsLabel
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: Setup UI

    func setupViews() {
        addSubViews([label, scaleSlider])
    }

    func setupLayout() {
        label.edgesToSuperView(including: [.top, .left, .bottom])
        label.layLeft(to: scaleSlider, constant: 8)
        scaleSlider.centerVertically()
        scaleSlider.layRightInSuperView(constant: 0)
        scaleSlider.heightAnchor(.equal, constant: 16)
    }
}
