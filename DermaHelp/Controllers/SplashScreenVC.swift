//
//  SplashScreenVC.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/6/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit
import EZConstraints

protocol LoginMethodPresenterDelegate: class {
    func presentSignUp()
    func presentLogin()
}

protocol MainScenePresenterDelegate: class {
    func presentMyAssessments()
}

class SplashScreenVC: ViewController, LayoutController {

    // MARK: Views
    
    private lazy var logoImageView = UIImageView(image: UIImage(named: "Logo"))
    private lazy var solidLogoImageView = UIImageView(image: UIImage(named: "Solid-logo"))
    private lazy var logoLabel = Label(text: "Derma Help", font: .roundedSystemFont(ofSize: 34, weight: .heavy))
    private lazy var featuresView = FeaturesView()
    private lazy var loginButton = FormButton(title: "Login", titleColor: .label, backColor: .systemFill)
    private lazy var signUpButton = FormButton(title: "Sign Up", titleColor: .white, backColor: .mainTint)
    
    // MARK: View Controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
        setupActions()
    }
    
    override func viewSafeAreaInsetsDidChange() {
        // Constraint can be added safely because Portrait rotation mode
        // is the only rotation mode enabled, unless, it is necessary to change the value
        // of a global constraint variable to avoid adding conflicting constraints every
        // time safe area insets change.
        logoImageView.layTopToSafeArea(constant: 32)
        loginButton.layBottomToSafeArea(constant: 24)
    }
    
    // MARK: Setup UI
    
    func setupViews() {
        view.addSubViews([
            logoImageView, solidLogoImageView, logoLabel,
            featuresView, loginButton, signUpButton
        ])
    }
    
    func setupLayout() {
        
        [logoImageView, solidLogoImageView].aspectRatio(multiplier: 1)
        [featuresView, signUpButton].layRightInSuperView(constant: 24)
        [solidLogoImageView, featuresView, loginButton].layLeftInSuperView(constant: 24)
        
        logoImageView.aspectRatio(by: view, multiplier: 0.4)
        logoImageView.layRightInSuperView(multiplier: 1.025, constant: -60)
        
        solidLogoImageView.layBelow(logoImageView, constant: -16)
        solidLogoImageView.aspectRatio(by: view, multiplier: 0.09)
        
        logoLabel.layLeftInSuperView(constant: 24)
        logoLabel.layBelow(solidLogoImageView, constant: 8)

        featuresView.layAbove(loginButton, multiplier: 0.98, constant: 48)
        featuresView.heightAnchor(with: view, multiplier: 0.12)

        loginButton.heightAnchor(.equal, constant: 44)
        
        signUpButton.layRight(to: loginButton, constant: 8)
        signUpButton.alignBottom(with: loginButton, constant: 0)
        signUpButton.sizeAnchor(with: loginButton)
    }
    
    private func setupActions() {
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
    }
    
    @objc
    private func didTapLoginButton() {
        let vc = LoginFormVC()
        vc.presentingDelegate = self
        vc.assessmentsPresenterDelegate = self
        present(vc, animated: true, completion: nil)
    }
    
    @objc
    private func didTapSignUpButton() {
        let vc = SignUpFormVC()
        vc.presentingDelegate = self
        vc.assessmentsPresenterDelegate = self
        present(vc, animated: true, completion: nil)
    }
}

extension SplashScreenVC: LoginMethodPresenterDelegate {
    func presentSignUp() {
        present(SignUpFormVC(), animated: true, completion: nil)
    }
    
    func presentLogin() {
        present(LoginFormVC(), animated: true, completion: nil)
    }
}

extension SplashScreenVC: MainScenePresenterDelegate {
    func presentMyAssessments() {
        navigationController?.setViewControllers([TabController()], animated: true)
    }
}
