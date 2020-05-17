//
//  ProfileVC.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/11/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit
import EZConstraints
import GoogleSignIn

class ProfileVC: ViewController {

    // MARK: Views
    
    private lazy var profileImageView = ProfileImageView()
    private lazy var editProfileButton = Button(title: "Edit", font: .roundedSystemFont(ofSize: 22, weight: .medium))
    private lazy var infoView = UserInfoView()
    private var editingView: EditingInfoView!
    private lazy var logoutButton = FormButton(title: "Logout", titleColor: .label, backColor: .systemFill)

    // MARK: Properties
    
    private weak var topConstraint: EZConstraint!
    private weak var bottomConstraint: EZConstraint!
    private var isEditingProfile = false
    
    // MARK: View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
        setupActions()
    }
    
    override func viewSafeAreaInsetsDidChange() {
        topConstraint.constant = view.safeAreaInsets.top + 24
        bottomConstraint.constant = -view.safeAreaInsets.bottom - 16
    }
    
    // MARK: Setup UI
    
    func setupViews() {
        view.addSubViews([
            profileImageView, editProfileButton, infoView, logoutButton
        ])
    }
    
    func setupLayout() {
        
        topConstraint = profileImageView.layTopInSuperView(constant: 16)
        profileImageView.layLeftInSuperView(constant: 24)
        profileImageView.aspectRatio(multiplier: 1)
        profileImageView.widthAnchor(with: view, multiplier: 0.25)
        
        editProfileButton.layRightInSuperView(constant: 24)
        editProfileButton.alignCenterVertically(with: profileImageView, constant: 0)
        
        infoView.layBelow(profileImageView, constant: 16)
        infoView.alignLeft(with: profileImageView, constant: 0)
        infoView.alignRight(with: editProfileButton, constant: 0)
        
        bottomConstraint = logoutButton.layBottomInSuperView(constant: 16)
        logoutButton.edgesToSuperView(including: [.left, .right], insets: .left(24) + .right(24))
        logoutButton.heightAnchor(.equal, constant: 40)
    }
    
    private func showEditingView() {
        editingView = EditingInfoView()
        view.addSubview(editingView)
        editingView.layBelow(profileImageView, constant: 8)
        editingView.alignLeft(with: profileImageView, constant: 0)
        editingView.alignRight(with: editProfileButton, constant: 0)
        editingView.show()
    }
    
    private func hideEditingView() {
        editingView.fade()
        editingView.removeFromSuperview()
        editingView = nil
    }
    
    private func setupActions() {
        editProfileButton.addTarget(self, action: #selector(didTapEditButton), for: .touchUpInside)
        logoutButton.addTarget(self, action: #selector(didTapLogoutButton), for: .touchUpInside)
    }
    
    // MARK: Actions
    
    @objc
    private func didTapEditButton() {
        isEditingProfile = !isEditingProfile
        let title = isEditingProfile ? "Done" : "Edit"
        editProfileButton.setTitle(title, for: .normal)
        if isEditingProfile {
            infoView.fade()
            showEditingView()
        } else {
            infoView.show()
            hideEditingView()
        }
    }
    
    @objc
    private func didTapLogoutButton() {
        AuthenticationProvider.shared.signOut { [weak self] (success) in
            if success {
                self?.navigationController?.setViewControllers([SplashScreenVC()], animated: true)
            } else {
                print("Couldn't sign out, Show some alert.")
            }
        }
    }
}
