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
    
    private lazy var label = Label()
    private lazy var scaleSlider = StatusSlider()
    
    // MARK: Properties
    
    var rate: Float = 0 {
        didSet {
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
        label.widthAnchor(.equal, constant: 80)
        scaleSlider.centerVertically()
        scaleSlider.layRightInSuperView(constant: 0)
        scaleSlider.heightAnchor(.equal, constant: 16)
    }
}
