//
//  LoginFormVC.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/6/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit
import EZConstraints
import GoogleSignIn

class LoginFormVC: ViewController, LayoutController {
    
    // MARK: Views
    
    private lazy var headingLabel = Label(text: "Welcome Back", font: .roundedSystemFont(ofSize: 32, weight: .heavy), color: .mainTint)
    private lazy var subHeadingLabel = Label(text: "We have been waiting for you", font: .roundedSystemFont(ofSize: 20, weight: .bold), color: .secondaryBlackLabel)
    private lazy var googleButton = GoogleButton()
    private lazy var separator = UISeparator()
    private lazy var emailTextField = TextField(placeholder: "Email address", type: .email)
    private lazy var passwordInputView = PasswordInputView()
    private lazy var forgotPwButton = Button(title: "Forgot password?")
    private lazy var loginButton = FormButton(title: "Login", titleColor: .white, backColor: .mainTint)
    private lazy var signUpQueLabel = Label(text: "Not a member?", font: .roundedSystemFont(ofSize: 16))
    private lazy var signUpButton = Button(title: "Sign up")
    
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
            emailTextField, passwordInputView, forgotPwButton,
            loginButton, signUpQueLabel, signUpButton
        ])
        loginButton.isEnabled = false
    }
    
    func setupLayout() {
        
        [headingLabel, subHeadingLabel].centerHorizontally()
        
        [googleButton, separator, emailTextField, passwordInputView,
         loginButton].edgesToSuperView(including: [.left, .right], insets: .left(24) + .right(24))
        
        [forgotPwButton, signUpQueLabel].layLeftInSuperView(constant: 24 + 4)
        
        [googleButton, emailTextField, passwordInputView,
         loginButton].heightAnchor(.equal, constant: 44)
        
        separator.heightAnchor(.equal, constant: 1)
        
        headingLabel.layTopInSuperView(constant: 56)
        subHeadingLabel.layBelow(headingLabel, constant: 8)
        googleButton.layBelow(subHeadingLabel, constant: 32)
        separator.layBelow(googleButton, constant: 24)
        emailTextField.layBelow(separator, constant: 24)
        passwordInputView.layBelow(emailTextField, constant: 12)
        forgotPwButton.layBelow(passwordInputView, constant: 12)
        loginButton.layBelow(forgotPwButton, constant: 24)
        signUpQueLabel.layBelow(loginButton, constant: 16)
        
        signUpButton.layRight(to: signUpQueLabel, constant: 8)
        signUpButton.alignCenterVertically(with: signUpQueLabel, constant: 0)
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
        forgotPwButton.addTarget(self, action: #selector(didTapForgotPwButton), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
        emailTextField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        passwordInputView.textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
    }
    
    // MARK: Actions
    
    @objc
    private func didTapGoogleButton() {
        GoogleAuthenticationProvider.signIn()
    }
    
    @objc
    private func didTapForgotPwButton() {
        // TODO: Recover password functionality
        print("Forgot Password")
    }
    
    @objc
    private func textFieldEditingChanged() {
        let isEmptyCredentials = (emailTextField.text ?? "").isEmpty || (passwordInputView.textField.text ?? "").isEmpty
        loginButton.isEnabled = isEmptyCredentials ? false : true
    }
    
    @objc
    private func didTapLoginButton() {
        let email = emailTextField.text ?? ""
        let password = passwordInputView.textField.text ?? ""
        
        guard email.evaluateEmail() else {
            presentWrongFormatAlert()
            return
        }
        
        guard password.evaluatePassword() else {
            presentWrongFormatAlert()
            return
        }
        
        AuthenticationProvider.shared.login(withEmail: email, password: password) { (error) in
            if let error = error {
                DispatchQueue.main.async {
                    let alert = AlertController.dismissingAlert(title: "Oops!", message: error.localizedDescription, dismissingTitle: "Try Again")
                    self.present(alert, animated: true, completion: nil)
                }
                return
            }
            // In case of success, Scene delegate has a state handler to handle
            // if the user has logged in or signed out.
        }
    }
    
    private func presentWrongFormatAlert() {
        let alert = AlertController.dismissingAlert(title: "Oops!", message: "Your email or password are empty or not in the correct format.", dismissingTitle: "Try Again")
        present(alert, animated: true, completion: nil)
    }
    
    @objc
    private func didTapSignUpButton() {
        dismiss(animated: true) {
            self.presentingDelegate?.presentSignUp()
        }
    }
}
