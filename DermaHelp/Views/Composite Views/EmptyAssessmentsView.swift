//
//  EmptyAssessmentsView.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/8/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

class EmptyAssessmentsView: UIView, LayoutController {

    // MARK: Views
        
    private lazy var doctorImageView = UIImageView(image: UIImage(named: "DoctorArt"))
    private lazy var mainLabel = Label(text: "No Assessment Found", font: .roundedSystemFont(ofSize: 20, weight: .semibold))
    private lazy var hintLabel = Label(text: "Tap the add button to add an assessment.", font: .roundedSystemFont(ofSize: 14), color: .secondaryBlackLabel)
    
    // MARK: Initializers
    
    init() {
        super.init(frame: .zero)
        setupViews()
        setupLayout()
        doctorImageView.contentMode = .scaleAspectFit
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: Setup UI
    
    func setupViews() {
        addSubViews([doctorImageView, mainLabel, hintLabel])
    }
    
    func setupLayout() {
        doctorImageView.edgesToSuperView()
        [mainLabel, hintLabel].centerHorizontally()
        mainLabel.layAbove(hintLabel, constant: 8)
        hintLabel.layBottomInSuperView(constant: 0)
    }
}
