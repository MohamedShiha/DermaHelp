//
//  BirthDayEditingVC.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 6/8/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

class BirthDayEditingVC: BaseEditingVC {
    
    // MARK: Views
    
    private let birthdayLabel = Label(text: "BirthDay", padding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0))
    private let datePicker = UIDatePicker()
    
    // MARK: Properties
    
    private var bottomConstraint: NSLayoutConstraint!
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = .localized(key: "birthday")
        hint = .localized(key: "birthday hint")
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        bottomConstraint.constant = -view.safeAreaInsets.bottom
    }
    
    // MARK: Setup UI
    
    override func setupViews() {
        super.setupViews()
        view.addSubViews([birthdayLabel, datePicker, saveButton])
        birthdayLabel.backgroundColor = .secondarySystemBackground
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        if let date = viewModel.birthDate {
            birthdayLabel.text = date.formattedWithMonthName
            birthdayLabel.textColor = .label
            datePicker.date = date
            saveButton.isEnabled = datePicker.date != date
        } else {
            birthdayLabel.text = "You have not set you birthdate yet."
            birthdayLabel.textColor = .secondaryBlackLabel
            saveButton.isEnabled = true
        }
    }
    
    override func setupLayout() {
        super.setupLayout()
        birthdayLabel.layBelow(hintLabel, constant: 24)
        [birthdayLabel, datePicker, saveButton].edgesToSuperView(including: [.left, .right])
        [birthdayLabel, saveButton].heightAnchor(.equal, constant: 44)
        saveButton.layAbove(datePicker, constant: 0)
        bottomConstraint = datePicker.layBottomInSuperView(constant: 0)
    }
    
    override func setupActions() {
        super.setupActions()
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
    }
    
    // MARK: Actions
    
    @objc
    private func datePickerValueChanged() {
        birthdayLabel.text = datePicker.date.formattedWithMonthName
        birthdayLabel.textColor = .label
        saveButton.isEnabled = viewModel.birthDate != datePicker.date
    }
    
    override func didTapSaveBtnHandler() {
        viewModel.updateUser(field: .birthDate, newValue: datePicker.date)
    }
    
    override func updateViewModel() {
        viewModel.birthDate = datePicker.date
    }
}
