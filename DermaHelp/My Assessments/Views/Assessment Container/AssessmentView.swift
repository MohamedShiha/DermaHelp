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
    
    let organNameLabel = Label(font: .roundedSystemFont(ofSize: 19, weight: .bold))
    let statusView = StatusView()
    let riskStatusScale = StatusScaleView(metricsLabel: "Risk")
    let nevusStatusScale = StatusScaleView(metricsLabel: "Nevus")
    let melanomaStatusScale = StatusScaleView(metricsLabel: "Melanoma")
    let colorStatusScale = StatusScaleView(metricsLabel: "Color")
    let dateLabel = Label(color: .secondaryLabel)
    let menuButton = MenuButton()
//    let getHelpButton = GetHelpButton()
    
    // MARK: Initializers
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .secondarySystemBackground
        clipsToBounds = false
        setupViews()
        setupLayout()
        dropShadow()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 16
        layer.shadowPath = UIBezierPath(rect: CGRect(x: -2, y: 4, width: frame.width + 4, height: frame.height)).cgPath
    }
    
    // MARK: Setup UI

    func setupViews() {
        addSubViews([
            organNameLabel, statusView, dateLabel, menuButton,
            riskStatusScale, nevusStatusScale, melanomaStatusScale,
            colorStatusScale/*, getHelpButton*/
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
            colorStatusScale].alignRight(with: dateLabel, constant: 0)
        [riskStatusScale, nevusStatusScale, melanomaStatusScale,
            colorStatusScale].alignLeft(with: organNameLabel, constant: 0)
        
        riskStatusScale.layBelow(organNameLabel, constant: 16)
        nevusStatusScale.layBelow(riskStatusScale, constant: 8)
        melanomaStatusScale.layBelow(nevusStatusScale, constant: 8)
        colorStatusScale.layBelow(melanomaStatusScale, constant: 8)
        
//        getHelpButton.layRightInSuperView(constant: 16)
//        getHelpButton.layRight(to: colorStatusScale, constant: 16)
//        getHelpButton.alignCenterVertically(with: colorStatusScale, constant: 0)
    }
    
    private func dropShadow() {
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 6
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}
