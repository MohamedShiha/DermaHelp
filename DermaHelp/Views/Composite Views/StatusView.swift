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
    
    var status: Assessment.Status = .low {
        didSet {
            setAppearance(by: status)
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
    
    private func setAppearance(by status: Assessment.Status) {
        var color = UIColor.clear
        var text = ""
        switch status {
        case .low:
            text = "Low"
            color = .systemGreen
        case .medium:
            text = "Medium"
            color = .systemYellow
        case .hazardous:
            text = "Hazardous"
            color = .systemRed
        }
        label.text = text
        label.textColor = color
        circle.backgroundColor = color
    }
}
