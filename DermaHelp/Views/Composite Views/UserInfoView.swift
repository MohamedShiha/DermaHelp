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
    
    private lazy var nameLabel = ProfileLabel(font: .roundedSystemFont(ofSize: 22, weight: .bold))
    private lazy var ageLabel = ProfileLabel(color: .secondaryBlackLabel)
    private lazy var genderLabel = ProfileLabel()
    private lazy var emailLabel = ProfileLabel()
    private lazy var assessmentsNumberLabel = ProfileLabel(font: .roundedSystemFont(ofSize: 22, weight: .semibold), color: .mainTint)
    private lazy var assessmentsLabel = ProfileLabel(text: "Conducted Assessments")
    
    // MARK: Properties
    
    var viewModel: UserViewModel? {
        didSet {
            setupContent()
        }
    }
    
    // MARK: Initializers
    
    init(viewModel: UserViewModel?) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        viewModel = nil
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
    
    private func setupContent() {
        nameLabel.text = viewModel?.name
        ageLabel.text = viewModel?.birthDate != nil ? "\(viewModel!.birthDate!.calculateAge())" : ""
        genderLabel.text = viewModel?.gender?.rawValue
        emailLabel.text = viewModel?.email
        assessmentsNumberLabel.text = "\(viewModel?.assessmentIds.count ?? 0)"
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
