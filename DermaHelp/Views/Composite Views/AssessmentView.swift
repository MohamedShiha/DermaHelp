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
    
    lazy var organNameLabel = Label(font: .roundedSystemFont(ofSize: 19, weight: .bold))
    lazy var statusView = StatusView()
    lazy var riskStatusScale = StatusScaleView(metricsLabel: "Risk")
    lazy var nevusStatusScale = StatusScaleView(metricsLabel: "Nevus")
    lazy var melanomaStatusScale = StatusScaleView(metricsLabel: "Melanoma")
    lazy var colorStatusScale = StatusScaleView(metricsLabel: "Color")
    lazy var dateLabel = Label(color: .secondaryLabel)
    lazy var menuButton = MenuButton()
    lazy var getHelpButton = GetHelpButton()
    
    // MARK: Initializers
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .secondarySystemBackground
        clipsToBounds = false
        setupViews()
        setupLayout()
        dropShadow()
        setupLongPressGesture()
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
            colorStatusScale, getHelpButton
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
        
        getHelpButton.layRightInSuperView(constant: 16)
        getHelpButton.layRight(to: colorStatusScale, constant: 16)
        getHelpButton.alignCenterVertically(with: colorStatusScale, constant: 0)
    }
    
    private func dropShadow() {
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 6
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
    private func setupLongPressGesture() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(recognizer:)))
        longPress.minimumPressDuration = 0.9
        addGestureRecognizer(longPress)
    }
    
    @objc
    private func handleLongPress(recognizer: UILongPressGestureRecognizer) {
        switch recognizer.state {
        case .began:
            scaleDown()
        case .ended:
            scaleToDefault()
        default:
            break
        }
    }
    
    private func scaleDown() {
        UIView.animate(withDuration: 0.3) {
            self.transform = CGAffineTransform.identity.scaledBy(x: 0.95, y: 0.95)
        }
    }
    
    private func scaleToDefault() {
        UIView.animate(withDuration: 0.3) {
            self.transform = CGAffineTransform.identity
        }
    }
}
