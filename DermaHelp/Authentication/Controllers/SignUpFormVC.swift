//
//  SignUpFormVC.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/7/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit
import EZConstraints

class SignUpFormVC: BaseAuthenticationVC {
    
    // MARK: Views

    private let repeatPwInputView = PasswordInputView(placeholder: "Confirm password")
    private let termsLabel = Label(text: "By signing up, you agree to our Terms and Conditions",
                                   font: .roundedSystemFont(ofSize: 13))
    private let signUpButton = ButtonWithLoadingActivity(title: "SIGN UP", cornerRadius: 8)
    private let loginQueLabel = Label(text: "Already a member?", font: .roundedSystemFont(ofSize: 16))
    private let loginButton = Button(title: "Login")

    // MARK: View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordInputView.textFieldDelegate = self
        repeatPwInputView.textFieldDelegate = self
        headingLabel.text = "Join Us"
        subHeadingLabel.text = "For a Skin Cancer-Free World"
    }
    
    // MARK: Setup UI
    
    override func setupViews() {
        super.setupViews()
        view.addSubViews([
            repeatPwInputView, termsLabel, signUpButton, loginQueLabel, loginButton
        ])
        signUpButton.isEnabled = false
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        [repeatPwInputView, signUpButton].edgesToSuperView(including: [.left, .right], insets: .left(24) + .right(24))
        
        [termsLabel, loginQueLabel].layLeftInSuperView(constant: 24 + 4)
        
        [repeatPwInputView, signUpButton].heightAnchor(.equal, constant: 44)
        
        repeatPwInputView.layBelow(passwordInputView, constant: 12)
        termsLabel.layBelow(repeatPwInputView, constant: 12)
        signUpButton.layBelow(termsLabel, constant: 24)
        loginQueLabel.layBelow(signUpButton, constant: 16)
        
        loginButton.layRight(to: loginQueLabel, constant: 8)
        loginButton.alignCenterVertically(with: loginQueLabel, constant: 0)
    }
    
    override func setupActions() {
        super.setupActions()
        signUpButton.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        repeatPwInputView.textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
    }
    
    // MARK: Actions
    
    override func editingChangedHandler() {
        let isEmptyEmail = (emailTextField.text ?? "").isEmpty
        let isEmptyPw = (passwordInputView.textField.text ?? "").isEmpty
        let isEmptyRepeatedPw = (repeatPwInputView.textField.text ?? "").isEmpty
        let isEmptyCredentials = isEmptyEmail || isEmptyPw || isEmptyRepeatedPw
        signUpButton.isEnabled = isEmptyCredentials ? false : true
    }
    
    @objc
    private func didTapSignUpButton() {
        
        signUpButton.showLoadingIndicator()
        
        let email = emailTextField.text ?? ""
        let password = passwordInputView.textField.text ?? ""
        let repeatedPw = repeatPwInputView.textField.text ?? ""
        
        guard NSRegularExpression.evaluate(email: email) else {
            presentSignUpAlert(message: "The email you entered is invalid.")
            return
        }
        
        guard NSRegularExpression.evaluate(password: password) else {
            let message = """
                The password you entered does not match our security rules.

                Your password should:
                range between 8 and 24 characters.
                contain 1 uppercase letter at least.
                contain 1 number at least.
                not contain whitespaces or special characters.
            """
            presentSignUpAlert(message: message)
            return
        }
        
        guard NSRegularExpression.evaluate(password: repeatedPw) else {
            presentSignUpAlert(message: "Passwords do not match.")
            return
        }
        
        AuthenticationProvider.shared.signUp(withEmail: email, password: password) { [weak self] (error) in
            if let error = error {
                DispatchQueue.main.async {
                    self?.presentSignUpAlert(message: error.localizedDescription)
                    self?.signUpButton.hideLoadingIndicator()
                }
                return
            }
            self?.signUpButton.hideLoadingIndicator()
            // In case of success, Scene delegate has a state handler to handle
            // if the user has logged in or signed out.
        }
    }
    
    private func presentSignUpAlert(message: String) {
        presentDismissingAlert(title: "Oops!", message: message)
        signUpButton.hideLoadingIndicator()
    }
    
    @objc
    private func didTapLoginButton() {
        dismiss(animated: true) {
            self.presentingDelegate?.presentLogin()
        }
    }
}

// MARK: Password TextField Delegate

extension SignUpFormVC: PasswordTextFieldDelegate {
    func didTapReturn(_ sender: UITextField) {
        if sender == passwordInputView.textField {
            repeatPwInputView.textField.becomeFirstResponder()
        } else if sender == repeatPwInputView.textField {
            didTapSignUpButton()
        }
    }
}
