//
//  EditingInfoView.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/11/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit
import EZConstraints

class EditingInfoView: UIView {
    
    // MARK: Views
    
    private lazy var editButton = Button(title: "Change profile photo")
    private lazy var nameTextfield = TextField(placeholder: "Full Name", type: .nickname)
    // Date Picker field for birth date
    private lazy var genderSegmentedControl = GenderSegmentedControl()
    private lazy var emailTextfield = TextField(placeholder: "Email", type: .email)
    private lazy var noteLabel = Label(text: "Changing password is not required", font: .roundedSystemFont(ofSize: 13), numberOfLines: 0)
    lazy var oldPasswordView = PasswordInputView(placeholder: "Old Password")
    lazy var passwordView = PasswordInputView(placeholder: "New Password")
    lazy var repeatPwView = PasswordInputView(placeholder: "Confirm Password")
    
    // MARK: Properties
    
    
    
    // MARK: Initializers
    
    init() {
        super.init(frame: .zero)
        setupViews()
        setupLayout()
        alpha = 0
        isHidden = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: Setup UI

    func setupViews() {
        addSubViews([
            editButton, nameTextfield, genderSegmentedControl, emailTextfield,
            noteLabel, oldPasswordView, passwordView, repeatPwView
        ])
    }

    func setupLayout() {

        [nameTextfield, emailTextfield, noteLabel, oldPasswordView,
         passwordView, repeatPwView].edgesToSuperView(including: [.left, .right])
        [nameTextfield, emailTextfield, oldPasswordView,
         passwordView, repeatPwView].heightAnchor(.equal, constant: 40)
        
        editButton.edgesToSuperView(including: [.top, .left])
        nameTextfield.layBelow(editButton, constant: 24)
        genderSegmentedControl.layLeftInSuperView(constant: 0)
        genderSegmentedControl.layBelow(nameTextfield, constant: 16)
        genderSegmentedControl.widthAnchor(with: self, multiplier: 0.65)
        emailTextfield.layBelow(genderSegmentedControl, constant: 16)
        noteLabel.layBelow(emailTextfield, constant: 24)
        oldPasswordView.layBelow(noteLabel, constant: 16)
        passwordView.layBelow(oldPasswordView, constant: 16)
        repeatPwView.layBelow(passwordView, constant: 16)
        repeatPwView.layBottomInSuperView(constant: 0)
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