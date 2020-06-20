//
//  BaseReauthenticationVC.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 6/9/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

class BaseReauthenticationVC: BasePasswordEditingVC {

    // MARK: Views
    
    private(set) var forgotPwButton = Button(title: "Forgot your password?", font: .roundedSystemFont(ofSize: 15, weight: .medium))
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordInputView.textField.placeholder = .localized(key: "confirm password")
        forgotPwButton.setTitle(.localized(key: "forgot?"), for: .normal)
    }
    
    // MARK: Setup UI
    
    override func setupViews() {
        super.setupViews()
        view.addSubview(forgotPwButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        forgotPwButton.layBelow(passwordInputView, constant: 16)
        forgotPwButton.centerHorizontally()
    }
    
    // MARK: Actions
    
    @objc
    private func didTapForgotPwButton() {
        // TODO: Recover password functionality
        print("Forgot Password")
    }
    
    override func didTapSaveBtnHandler() {
        saveButton.hideLoadingIndicator()
        if NSRegularExpression.evaluate(password: passwordInputView.textField.text ?? "") {
            viewModel.reauthenticate(with: passwordInputView.textField.text ?? "") { [weak self] (error) in
                self?.didReauthenticateWith(error)
            }
        } else {
            presentDismissingAlert(title: .localized(key: "invalid password"))
        }
    }
    
    func didReauthenticateWith(_ error: Error?) { }
}
