//
//  LoginFormVC.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/6/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit
import EZConstraints

class LoginFormVC: BaseAuthenticationVC {
    
    // MARK: Views

    private let forgotPwButton = Button(title: "Forgot password?")
    private let loginButton = ButtonWithLoadingActivity(title: "Login", cornerRadius: 8)
    private let signUpQueLabel = Label(text: "Not a member?", font: .roundedSystemFont(ofSize: 16))
    private let signUpButton = Button(title: "Sign up")
    
    // MARK: View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordInputView.textFieldDelegate = self
    }

    // MARK: Setup UI
    
    override func setupViews() {
        super.setupViews()
        headingLabel.localizingKey = "welcome"
        subHeadingLabel.localizingKey = "welcome status"
        forgotPwButton.localizingKey = "forgot?"
        loginButton.localizingKey = "login"
        signUpQueLabel.localizingKey = "not member?"
        signUpButton.localizingKey = "sign up"
        loginButton.isEnabled = false
        view.addSubViews([
            forgotPwButton, loginButton, signUpQueLabel, signUpButton
        ])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        [forgotPwButton, signUpQueLabel].layLeftInSuperView(constant: 24 + 4)
        
        loginButton.edgesToSuperView(including: [.left, .right], insets: .left(24) + .right(24))
        loginButton.heightAnchor(.equal, constant: 44)
    
        forgotPwButton.layBelow(passwordInputView, constant: 12)
        loginButton.layBelow(forgotPwButton, constant: 24)
        signUpQueLabel.layBelow(loginButton, constant: 16)
        
        signUpButton.layRight(to: signUpQueLabel, constant: 8)
        signUpButton.alignCenterVertically(with: signUpQueLabel, constant: 0)
    }
    
    override func setupActions() {
        super.setupActions()
        forgotPwButton.addTarget(self, action: #selector(didTapForgotPwButton), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
    }
    
    // MARK: Actions
    
    @objc
    private func didTapForgotPwButton() {
        print("Forgot Password")
    }
    
    override func editingChangedHandler() {
        let isEmptyCredentials = (emailTextField.text ?? "").isEmpty || (passwordInputView.textField.text ?? "").isEmpty
        loginButton.isEnabled = isEmptyCredentials ? false : true
    }
    
    @objc
    private func didTapLoginButton() {
        
        loginButton.showLoadingIndicator()
        
        let email = emailTextField.text ?? ""
        let password = passwordInputView.textField.text ?? ""
        
        guard !email.isEmpty && !password.isEmpty else {
            presentLoginAlert(message: .localized(key: "credentials alert"))
            return
        }
        
        guard NSRegularExpression.evaluate(email: email) else {
            presentLoginAlert(message: .localized(key: "invalid email"))
            return
        }
        
        guard NSRegularExpression.evaluate(password: password) else {
            presentLoginAlert(message: .localized(key: "invalid password"))
            return
        }
        
        AuthenticationProvider.shared.login(withEmail: email, password: password) { [weak self] (error) in
            if let error = error {
                DispatchQueue.main.async {
                    self?.presentLoginAlert(message: error.localizedDescription)
                    self?.loginButton.hideLoadingIndicator()
                }
                return
            }
            self?.loginButton.hideLoadingIndicator()
            // In case of success, Scene delegate has a state handler to handle
            // if the user has logged in or signed out.
        }
    }
    
    private func presentLoginAlert(message: String) {
        presentDismissingAlert(title: .localized(key: "oops"), message: message)
        loginButton.hideLoadingIndicator()
    }
    
    @objc
    private func didTapSignUpButton() {
        dismiss(animated: true) {
            self.presentingDelegate?.presentSignUp()
        }
    }
}

// MARK: Password TextField Delegate

extension LoginFormVC: PasswordTextFieldDelegate {
    func didTapReturn(_ sender: UITextField) {
        didTapLoginButton()
    }
}
