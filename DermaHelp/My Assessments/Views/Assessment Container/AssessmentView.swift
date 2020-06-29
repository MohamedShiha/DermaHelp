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
    
    let statusView = StatusView()
    let imageView = UIImageView()
    let riskStatusScale = StatusScaleView(metricsLabel: .localized(key: "risk"))
    let dateLabel = Label(font: .roundedSystemFont(ofSize: 16), color: .secondaryLabel)
    let menuButton = MenuButton()
    
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
        imageView.layer.cornerRadius = 12
        layer.cornerRadius = 16
        layer.shadowPath = UIBezierPath(rect: CGRect(x: -2, y: 4, width: frame.width + 4, height: frame.height)).cgPath
    }
    
    // MARK: Setup UI

    func setupViews() {
        imageView.clipsToBounds = true
        addSubViews([
            imageView, statusView, dateLabel, menuButton, riskStatusScale
        ])
    }

    func setupLayout() {
        
        imageView.edgesToSuperView(including: [.top, .left], insets: .top(16) + .left(16))
        imageView.sizeAnchor(CGSize(width: 52, height: 52))
        
        statusView.layRight(to: imageView, constant: 16)
        statusView.alignTop(with: imageView, constant: 8)
        
        dateLabel.alignLeft(with: statusView, constant: 0)
        dateLabel.layBelow(statusView, constant: 4)
        
        menuButton.layRightInSuperView(constant: 8)
        menuButton.squareSizeWith(sideLengthOf: 26)
        menuButton.alignTop(with: imageView, constant: 4)
        
        riskStatusScale.widthAnchor(with: self, multiplier: 0.75)
        riskStatusScale.alignLeft(with: imageView, constant: 6)
        riskStatusScale.layBelow(imageView, constant: 16)
    }
    
    private func dropShadow() {
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 6
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}
