//
//  NewPasswordEditingVC.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 6/8/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

class NewPasswordEditingVC: BasePasswordEditingVC {
    
    // MARK: Views
    
    private let repeatPwInputView = PasswordInputView(placeholder: "Confirm Password")
    private let rulesLabel = PasswordRulesLabel(text: "Your password should:")
    private let eightCharRuleLabel = PasswordRulesLabel(text: "- range between 8 and 24 characters.")
    private let upperCharRuleLabel = PasswordRulesLabel(text: "- contain 1 uppercase letter at least.")
    private let numericRuleLabel = PasswordRulesLabel(text: "- contain 1 number at least.")
    private let blackListedRuleLabel = PasswordRulesLabel(text: "- not contain whitespaces or special characters.")
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "New Password"
        passwordInputView.textField.placeholder = "New Password"
        saveButton.setTitle("CONFIRM", for: .normal)
        hint = "Please choose a new password. DermaHelp uses strong password rules to ensure that your data and personal information are secure."
        repeatPwInputView.textFieldDelegate = self
    }
    
    // MARK: Setup UI
    
    override func setupViews() {
        super.setupViews()
        view.addSubViews([repeatPwInputView, rulesLabel, eightCharRuleLabel,
                          upperCharRuleLabel, numericRuleLabel, blackListedRuleLabel])
    }
    
    override func setupLayout() {
        super.setupLayout()
        repeatPwInputView.layBelow(passwordInputView, constant: 16)
        repeatPwInputView.alignLeft(with: passwordInputView, constant: 0)
        repeatPwInputView.alignRight(with: passwordInputView, constant: 0)
        repeatPwInputView.heightAnchor(with: passwordInputView)
        
        rulesLabel.layBelow(repeatPwInputView, constant: 16)
        rulesLabel.alignLeft(with: repeatPwInputView, constant: 4)
        
        [eightCharRuleLabel, upperCharRuleLabel, numericRuleLabel,
         blackListedRuleLabel].alignLeft(with: rulesLabel, constant: 4)
        
        eightCharRuleLabel.layBelow(rulesLabel, constant: 8)
        upperCharRuleLabel.layBelow(eightCharRuleLabel, constant: 8)
        numericRuleLabel.layBelow(upperCharRuleLabel, constant: 8)
        blackListedRuleLabel.layBelow(numericRuleLabel, constant: 8)
    }
    
    override func setupActions() {
        super.setupActions()
        repeatPwInputView.textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
    }
    
    // MARK: Actions
    
    override func textFieldEditingChanged() {
        let pw = passwordInputView.textField.text ?? ""
        let repeated = repeatPwInputView.textField.text ?? ""
        saveButton.isEnabled = !pw.isEmpty && !repeated.isEmpty
        
        let activeColor = UIColor.mainTint
        let inactiveColor = UIColor.secondaryBlackLabel
        eightCharRuleLabel.animateTextColor(to: pw.count >= 8 && pw.count <= 24 ? activeColor : inactiveColor)
        upperCharRuleLabel.animateTextColor(to: NSRegularExpression.containsAnUpperCase(string: pw) ? activeColor : inactiveColor)
        numericRuleLabel.animateTextColor(to: NSRegularExpression.containsADigit(string: pw) ? activeColor : inactiveColor)
        blackListedRuleLabel.animateTextColor(to: !NSRegularExpression.containsASpecialChar(string: pw) && !pw.isEmpty ? activeColor : inactiveColor)
    }
    
    override func didTapSaveBtnHandler() {
        
        saveButton.hideLoadingIndicator()
        
        let pw = passwordInputView.textField.text ?? ""
        let repeated = repeatPwInputView.textField.text ?? ""
        
        let areValid = NSRegularExpression.evaluate(password: pw) && NSRegularExpression.evaluate(password: repeated)
        let areMatching = pw == repeated
        
        if areMatching && areValid {
            saveButton.showLoadingIndicator()
            viewModel.updatePassword(pw) { [weak self] (error) in
                if let error = error {
                    self?.presentDismissingAlert(title: error.localizedDescription)
                } else {
                    let alert = AlertController(title: "Your password has been updated successfully.", message: "", buttonStackAxis: .horizontal)
                    alert.createAlert(title: "Okay", action: .secondary, alertStyle: .cancel) {
                        alert.dismiss(animated: true, completion: nil)
                        self?.navigationController?.popToRootViewController(animated: true)
                    }
                    self?.present(alert, animated: true, completion: nil)
                }
            }
        } else {
            
            var title = ""
            
            if !areMatching { title = "Your passwords do not match." }
            if !NSRegularExpression.evaluate(password: pw) {
                title = "Your password does not match the specified rules."
            }
            
            presentDismissingAlert(title: title)
        }
    }
}
