//
//  UserInfoView.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/11/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit
import EZConstraints

class UserInfoView: UIView, LayoutController {

    // MARK: Views
    
    private lazy var nameLabel = ProfileLabel(text: "Mohamed Reda Shiha", font: .roundedSystemFont(ofSize: 22, weight: .bold))
    private lazy var ageLabel = ProfileLabel(text: "22 years old", color: .secondaryBlackLabel)
    private lazy var genderLabel = ProfileLabel(text: "Male")
    private lazy var emailLabel = ProfileLabel(text: "mohamedshiha15@gmail.com")
    private lazy var assessmentsNumberLabel = ProfileLabel(text: "4", font: .roundedSystemFont(ofSize: 22, weight: .semibold), color: .mainTint)
    private lazy var assessmentsLabel = ProfileLabel(text: "Conducted Assessments")
    
    // MARK: Properties
    
    // TODO: View model to set values
    
    // MARK: Initializers
    
    init() {
        super.init(frame: .zero)
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: Setup UI

    func setupViews() {
        addSubViews([
            nameLabel, ageLabel, genderLabel, emailLabel,
            assessmentsNumberLabel , assessmentsLabel
        ])
    }

    func setupLayout() {
        [nameLabel, ageLabel, genderLabel, emailLabel].edgesToSuperView(including: [.left, .right])
        nameLabel.layTopInSuperView(constant: 0)
        ageLabel.layBelow(nameLabel, constant: 8)
        genderLabel.layBelow(ageLabel, constant: 24)
        emailLabel.layBelow(genderLabel, constant: 16)
        assessmentsNumberLabel.layBelow(emailLabel, constant: 16)
        assessmentsNumberLabel.layLeftInSuperView(constant: 0)
        assessmentsLabel.layRight(to: assessmentsNumberLabel, constant: 4)
        assessmentsLabel.alignBottom(with: assessmentsNumberLabel, constant: 0)
    }
    
    // MARK: Animations
    
    func fade() {
        animateAlpha(0)
        isHidden = true
    }
    
    func show() {
        animateAlpha(1)
        isHidden = false
    }
}
