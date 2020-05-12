//
//  ManualView.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/10/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit
import EZConstraints

class ManualView: UIView, LayoutController {
    
    // MARK: Views
    
    private lazy var titleLabel = Label(text: "How it works", font: .roundedSystemFont(ofSize: 20, weight: .bold))
    private lazy var manualLabel = Label(text: "DermaHelp analyses your captured photos in a highly intelligent way to provide you with the most accurate results, raises your awareness, and shows you the nearest dermatologist on the map.", font: .roundedSystemFont(ofSize: 17), numberOfLines: 0)
    
    // MARK: Initializers
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .secondarySystemBackground
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 12
    }
    
    // MARK: Setup UI

    func setupViews() {
        addSubViews([
            titleLabel, manualLabel
        ])
    }

    func setupLayout() {
        titleLabel.edgesToSuperView(including: [.top, .left, .right], insets: .top(8) + .left(16) + .right(12))
        manualLabel.layBelow(titleLabel, constant: 8)
        manualLabel.alignLeft(with: titleLabel, constant: 0)
        manualLabel.edgesToSuperView(including: [.bottom, .right], insets: .bottom(16) + .right(12))
    }
}
