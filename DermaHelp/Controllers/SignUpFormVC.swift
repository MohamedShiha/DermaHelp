//
//  SignUpFormVC.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/7/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit
import EZConstraints
import GoogleSignIn

class SignUpFormVC: ViewController, LayoutController {
    
    // MARK: Views
    
    private lazy var headingLabel = Label(text: "Join Us", font: .roundedSystemFont(ofSize: 32, weight: .heavy), color: .mainTint)
    private lazy var subHeadingLabel = Label(text: "For a Skin Cancer-Free World", font: .roundedSystemFont(ofSize: 20, weight: .bold), color: .secondaryBlackLabel)
    private lazy var googleButton = GoogleButton()
    private lazy var separator = UISeparator()
    private lazy var emailTextField = TextField(placeholder: "Email address", type: .email)
    private lazy var passwordInputView = PasswordInputView()
    private lazy var repeatPwInputView = PasswordInputView(placeholder: "Confirm password")
    private lazy var termsLabel = Label(text: "By signing up, you agree to our Terms and Conditions", font: .roundedSystemFont(ofSize: 13))
    private lazy var signUpButton = FormButton(title: "SIGN UP", titleColor: .white, backColor: .mainTint)
    private lazy var loginQueLabel = Label(text: "Already a member?", font: .roundedSystemFont(ofSize: 16))
    private lazy var loginButton = Button(title: "Login")
    
    // MARK: Properties
    
    weak var presentingDelegate: LoginMethodPresenterDelegate?
    
    // MARK: View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
        setupActions()
        setupGestures()
        GIDSignIn.sharedInstance()?.presentingViewController = self
    }
    
    // MARK: Setup UI
    
    func setupViews() {
        view.addSubViews([
            headingLabel, subHeadingLabel, googleButton, separator,
            emailTextField, passwordInputView, repeatPwInputView,
            termsLabel, signUpButton, loginQueLabel, loginButton
        ])
    }
    
    func setupLayout() {
        
        [headingLabel, subHeadingLabel].centerHorizontally()
        
        [googleButton, separator, emailTextField, passwordInputView, repeatPwInputView,
        signUpButton].edgesToSuperView(including: [.left, .right], insets: .left(24) + .right(24))
        
        [termsLabel, loginQueLabel].layLeftInSuperView(constant: 24 + 4)
        
        [googleButton, emailTextField, passwordInputView,
        repeatPwInputView, signUpButton].heightAnchor(.equal, constant: 44)
        
        separator.heightAnchor(.equal, constant: 1)
        
        headingLabel.layTopInSuperView(constant: 56)
        subHeadingLabel.layBelow(headingLabel, constant: 8)
        googleButton.layBelow(subHeadingLabel, constant: 32)
        separator.layBelow(googleButton, constant: 24)
        emailTextField.layBelow(separator, constant: 24)
        passwordInputView.layBelow(emailTextField, constant: 12)
        repeatPwInputView.layBelow(passwordInputView, constant: 12)
        termsLabel.layBelow(repeatPwInputView, constant: 12)
        signUpButton.layBelow(termsLabel, constant: 24)
        loginQueLabel.layBelow(signUpButton, constant: 16)
        
        loginButton.layRight(to: loginQueLabel, constant: 8)
        loginButton.alignCenterVertically(with: loginQueLabel, constant: 0)
    }
    
    private func setupGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc
    private func dismissKeyboard() {
        view.endEditing(false)
    }
    
    private func setupActions() {
        googleButton.addTarget(self, action: #selector(didTapGoogleButton), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
    }
    
    @objc
    private func handleKeyboardNotification(notification : Notification) {
        let isShowing = notification.name == UIResponder.keyboardWillShowNotification
        view.frame.origin.y = isShowing ? -100 : 0
    }
    
    // MARK: Actions
    
    @objc
    private func didTapGoogleButton() {
        GoogleAuthenticationProvider.signIn()
    }
    
    @objc
    private func didTapSignUpButton() {
        let email = emailTextField.text ?? ""
        let password = passwordInputView.textField.text ?? ""
        AuthenticationProvider.shared.signUp(withEmail: email, password: password) { (error) in
            guard error == nil else {
                print("Error signing up, Show some alert.")
                return
            }
            // In case of success, Scene delegate has a state handler to handle
            // if the user has logged in or signed out.
        }
    }
    
    @objc
    private func didTapLoginButton() {
        dismiss(animated: true) {
            self.presentingDelegate?.presentLogin()
        }
    }
}
