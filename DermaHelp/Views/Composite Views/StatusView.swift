//
//  StatusView.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/9/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

class StatusView: UIView, LayoutController {

    // MARK: Views
    
    private lazy var label = Label(font: .roundedSystemFont(ofSize: 19, weight: .semibold))
    private lazy var circle = UIView()
    
    // MARK: Properties

    var severity: Assessment.Severity = .low {
        didSet {
            label.text = severity.rawValue
            setAppearance(by: severity)
        }
    }
    
    // MARK: Initializers
    
    init() {
        super.init(frame: .zero)
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        circle.layer.cornerRadius = circle.bounds.height / 2
    }
    
    // MARK: Setup UI
    
    func setupViews() {
        addSubViews([circle, label])
    }
    
    func setupLayout() {
        circle.layLeftInSuperView(constant: 0)
        [circle, label].centerVertically()
        circle.squareSizeWith(sideLengthOf: 6)
        label.layRight(to: circle, constant: 6)
        label.edgesToSuperView(including: [.top, .right, .bottom])
    }
    
    private func setAppearance(by severity: Assessment.Severity) {
        var color = UIColor.clear
        switch severity {
        case .low:
            color = .systemGreen
        case .medium:
            color = .systemYellow
        case .hazardous:
            color = .systemRed
        }
        label.textColor = color
        circle.backgroundColor = color
    }
}
