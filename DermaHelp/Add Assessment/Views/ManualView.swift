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
    
    private let titleLabel = Label(text: "How it works", font: .roundedSystemFont(ofSize: 20, weight: .bold))
    private let manualLabel = Label(text: "Manual", font: .roundedSystemFont(ofSize: 17), numberOfLines: 0)
    
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
        layer.cornerRadius = 12
    }
    
    // MARK: Setup UI

    func setupViews() {
        backgroundColor = .secondarySystemBackground
        titleLabel.localizingKey = "how it works"
        manualLabel.localizingKey = "manual"
        addSubViews([titleLabel, manualLabel])
    }

    func setupLayout() {
        titleLabel.edgesToSuperView(including: [.top, .left, .right], insets: .top(8) + .left(16) + .right(12))
        manualLabel.layBelow(titleLabel, constant: 8)
        manualLabel.alignLeft(with: titleLabel, constant: 0)
        manualLabel.edgesToSuperView(including: [.bottom, .right], insets: .bottom(16) + .right(12))
    }
}
