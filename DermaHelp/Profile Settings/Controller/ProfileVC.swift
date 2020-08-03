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
    
    private let profileImageView = ProfileImageView()
    private let editImageButton = Button(title: .localized(key: "change photo"))
    private let settingsTableView: ProfileSettingsTableView

    // MARK: Properties
    
    private weak var topConstraint: EZConstraint!
    let viewModel: UserViewModel
    var imagePicker: ImagePicker!
    
    // MARK: Initializers
    
    init(viewModel: UserViewModel) {
        self.viewModel = viewModel
        settingsTableView = ProfileSettingsTableView(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
        viewModel.fetchCurrentUser()
    }
    
    required init?(coder: NSCoder) {
        viewModel = UserViewModel(user: User())
        settingsTableView = ProfileSettingsTableView(viewModel: viewModel)
        super.init(coder: coder)
    }
    
    // MARK: View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
        setupActions()
        settingsTableView.parentDelegate = self
        removeNavigationBackButton()
        imagePicker = ImagePicker(presentationController: self, delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hidesBottomBarWhenPushed = false
        navigationController?.navigationBar.isHidden = true
        showUserData()
    }
    
    override func viewSafeAreaInsetsDidChange() {
        topConstraint.constant = view.safeAreaInsets.top + 28
    }
    
    // MARK: Setup UI
    
    func setupViews() {
        view.addSubViews([
            profileImageView, editImageButton, settingsTableView
        ])
    }
    
    func setupLayout() {
        topConstraint = profileImageView.layTopInSuperView(constant: 28)
        [profileImageView, editImageButton].centerHorizontally()
        profileImageView.aspectRatio(multiplier: 1)
        profileImageView.widthAnchor(with: view, multiplier: 0.35)
        
        editImageButton.layBelow(profileImageView, constant: 8)
        
        settingsTableView.layBelow(editImageButton, constant: 28)
        settingsTableView.edgesToSuperView(including: [.left, .bottom, .right])
    }
    
    private func setupActions() {
        editImageButton.addTarget(self, action: #selector(didTapEditButton), for: .touchUpInside)
    }
    
    private func updateTabBar(with image: UIImage?) {
        let avatar = image ?? UIImage.profilePlaceholder
        tabBarController?.tabBar.items?[1].image = avatar?.roundedImageWithBorder(width: 0)
        tabBarController?.tabBar.items?[1].selectedImage = avatar?.roundedImageWithBorder(width: 2, color: .mainTint)
    }
    
    private func showUserData() {
        settingsTableView.viewModel = viewModel
        settingsTableView.reloadData()
        profileImageView.image = viewModel.picture ?? UIImage.profilePlaceholder
    }
    
    private func updateAssessments() {
        if let nav = (tabBarController?.viewControllers?.first as? UINavigationController),
            let assessmentsVC = nav.viewControllers.first as? MyAssessmentsVC {
            assessmentsVC.assessments = Assessments(userVM: viewModel)
        }
    }
    
    // MARK: Actions
    
    @objc
    private func didTapEditButton() {
        imagePicker.presentOptions(from: view)
    }
}

// MARK: UserViewModel Delegate

extension ProfileVC: UserViewModelDelegate {
    func didFetchUser(_ error: Error?) {
        if let error = error {
            presentDismissingAlert(title: error.localizedDescription)
        } else {
            updateAssessments()
            showUserData()
            updateTabBar(with: viewModel.picture)
        }
    }
}

// MARK: ImagePicker Delegate

extension ProfileVC: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        if let image = image {
            profileImageView.image = image
            viewModel.picture = image
            updateTabBar(with: image)
            viewModel.updateUser(field: .picture, newValue: image)
        }
    }
}

// MARK: TableView Presenting VC Delegate

extension ProfileVC: TableViewPresentingVCDelegate {

    func presentAlert(title: String, message: String?, dismissingTitle: String) {
        presentDismissingAlert(title: title, message: message, dismissingText: dismissingTitle)
    }

    func presentAlertWithHandler(title: String, message: String?,
                                 buttonsStackAxis: NSLayoutConstraint.Axis, actionTitle: String,
                                 actionType: AlertController.Action,
                                 alertStyle: UIAlertAction.Style, _ handler: (() -> Void)?) {

        presentAlert(title: title, message: message, buttonsStackAxis: buttonsStackAxis,
                     actionTitle: actionTitle, actionType: actionType, alertStyle: alertStyle,
                     handler: handler)
    }
    
    func navigate(to vc: UIViewController) {
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func clearAssessments() {
        viewModel.assessmentIds = []
        viewModel.clearAssessments()
        settingsTableView.reloadData()
        updateAssessments()
    }
    
    func logOut() {
        AuthenticationProvider.shared.logOut { [weak self] (error) in
            if let error = error {
                self?.presentDismissingAlert(title: error.localizedDescription)
                return
            }
            self?.navigationController?.setViewControllers([SplashScreenVC()], animated: true)
        }
    }
}
