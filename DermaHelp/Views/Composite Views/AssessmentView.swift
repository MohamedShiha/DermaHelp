//
//  AssessmentView.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/9/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit
import EZConstraints

class AssessmentView: UIView, LayoutController {

    // MARK: Views
    
    private lazy var organNameLabel = Label(text: "Right Leg", font: .roundedSystemFont(ofSize: 19, weight: .bold))
    private lazy var statusView = StatusView()
    private lazy var riskStatusScale = StatusScaleView(metricsLabel: "Risk")
    private lazy var nevusStatusScale = StatusScaleView(metricsLabel: "Nevus")
    private lazy var melanomaStatusScale = StatusScaleView(metricsLabel: "Melanoma")
    private lazy var colorStatusScale = StatusScaleView(metricsLabel: "Color")
    private lazy var dateLabel = Label(text: "21/2/2020", color: .secondaryLabel)
    private lazy var menuButton = MenuButton()
    
    
    // MARK: Properties
    
    // MARK: Initializers
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .secondarySystemBackground
        clipsToBounds = false
        setupViews()
        setupLayout()
        dropShadow()
        statusView.status = .low
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 12
        layer.shadowPath = UIBezierPath(rect: CGRect(x: -2, y: 4, width: frame.width + 4, height: frame.height)).cgPath
    }
    
    // MARK: Setup UI

    func setupViews() {
        addSubViews([
            organNameLabel, statusView, dateLabel, menuButton,
            riskStatusScale, nevusStatusScale, melanomaStatusScale,
            colorStatusScale
        ])
    }

    func setupLayout() {
        
        organNameLabel.edgesToSuperView(including: [.top, .left], insets: .top(16) + .left(16))
        statusView.layRight(to: organNameLabel, constant: 16)
        statusView.alignCenterVertically(with: organNameLabel, constant: 0)
        
        menuButton.layRightInSuperView(constant: 8)
        menuButton.squareSizeWith(sideLengthOf: 26)
        dateLabel.layLeft(to: menuButton, constant: 8)
        [menuButton, dateLabel].alignCenterVertically(with: organNameLabel, constant: 0)
        
        [riskStatusScale, nevusStatusScale, melanomaStatusScale,
            colorStatusScale].widthAnchor(with: self, multiplier: 0.65)
        [riskStatusScale, nevusStatusScale, melanomaStatusScale,
            colorStatusScale].alignLeft(with: organNameLabel, constant: 0)
        
        riskStatusScale.layBelow(organNameLabel, constant: 16)
        nevusStatusScale.layBelow(riskStatusScale, constant: 8)
        melanomaStatusScale.layBelow(nevusStatusScale, constant: 8)
        colorStatusScale.layBelow(melanomaStatusScale, constant: 8)
    }
    
    private func dropShadow() {
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 6
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}
