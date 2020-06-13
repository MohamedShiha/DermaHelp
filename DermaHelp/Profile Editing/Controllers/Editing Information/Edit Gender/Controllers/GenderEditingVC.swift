//
//  GenderEditingVC.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 6/8/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

class GenderEditingVC: BaseEditingVC {

    // MARK: Views
    
    private let genderSegmentedControl = GenderSegmentedControl()
    
    // MARK: Properties
    
    private var bottomConstraint: NSLayoutConstraint!
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Gender"
        hint = "Your gender affects the analysis result as it is different between different genders."
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        bottomConstraint.constant = -view.safeAreaInsets.bottom
    }
    
    override func setupViews() {
        super.setupViews()
        view.addSubViews([genderSegmentedControl, saveButton])
        if let gender = viewModel.gender {
            genderSegmentedControl.selectedSegmentIndex = gender == .male ? 0 : 1
        }
    }
    
    override func setupLayout() {
        super.setupLayout()
        genderSegmentedControl.layBelow(hintLabel, constant: 24)
        genderSegmentedControl.centerHorizontally()
        genderSegmentedControl.widthAnchor(with: view, multiplier: 0.65)
        saveButton.edgesToSuperView(including: [.left, .right])
        saveButton.heightAnchor(.equal, constant: 44)
        bottomConstraint = saveButton.layBottomInSuperView(constant: 0)
    }
    
    override func setupActions() {
        super.setupActions()
        genderSegmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
    }
    
    // MARK: Actions
    
    @objc
    private func segmentedControlValueChanged() {
        saveButton.isEnabled = genderSegmentedControl.gender != viewModel.gender
    }
    
    override func didTapSaveBtnHandler() {
        if let gender = genderSegmentedControl.gender {
            viewModel.updateUser(field: .gender, newValue: gender.rawValue)
        }
    }
    
    override func updateViewModel() {
        viewModel.gender = genderSegmentedControl.gender
    }
}
