//
//  BaseAuthenticationVC.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 6/12/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit
import GoogleSignIn
import EZConstraints

protocol BaseAuthenticationHandlers {
    func editingChangedHandler()
}

class BaseAuthenticationVC: ViewController, LayoutController, BaseAuthenticationHandlers {
    
    // MARK: Views
    
    let headingLabel = Label(text: "Welcome Back", font: .roundedSystemFont(ofSize: 32, weight: .heavy), color: .mainTint)
    let subHeadingLabel = Label(text: "We have been waiting for you", font: .roundedSystemFont(ofSize: 20, weight: .bold), color: .secondaryBlackLabel)
    let googleButton = GoogleButton()
    let separator = UISeparator()
    let emailTextField = TextField(placeholder: "Email address", type: .email)
    let passwordInputView = PasswordInputView()
    
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
        emailTextField.delegate = self
    }
    
    // MARK: Setup UI
    
    func setupViews() {
        view.addSubViews([
            headingLabel, subHeadingLabel, googleButton, separator,
            emailTextField, passwordInputView
        ])
    }
    
    func setupLayout() {
        
        [headingLabel, subHeadingLabel].centerHorizontally()
        
        [googleButton, separator, emailTextField, passwordInputView
            ].edgesToSuperView(including: [.left, .right], insets: .left(24) + .right(24))
        
        [googleButton, emailTextField, passwordInputView].heightAnchor(.equal, constant: 44)
        
        separator.heightAnchor(.equal, constant: 1)
        
        headingLabel.layTopInSuperView(constant: 56)
        subHeadingLabel.layBelow(headingLabel, constant: 8)
        googleButton.layBelow(subHeadingLabel, constant: 32)
        separator.layBelow(googleButton, constant: 24)
        emailTextField.layBelow(separator, constant: 24)
        passwordInputView.layBelow(emailTextField, constant: 12)
    }
    
    private func setupGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func setupActions() {
        googleButton.addTarget(self, action: #selector(didTapGoogleButton), for: .touchUpInside)
        emailTextField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        passwordInputView.textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
    }
    
    // MARK: Actions
    
    @objc
    private func dismissKeyboard() {
        view.endEditing(false)
    }
    
    @objc
    private func didTapGoogleButton() {
        GoogleAuthenticationProvider.signIn()
    }
    
    @objc
    func textFieldEditingChanged() {
        editingChangedHandler()
    }
    
    // MARK: BaseAuthenticationHandlers Stubs
    
    func editingChangedHandler() { }
}

// MARK: TextField Delegate

extension BaseAuthenticationVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == emailTextField {
            passwordInputView.textField.becomeFirstResponder()
        }
        return true
    }
}
