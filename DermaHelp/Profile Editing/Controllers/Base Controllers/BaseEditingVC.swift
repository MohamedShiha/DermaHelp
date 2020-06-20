//
//  BaseEditingVC.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 6/7/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit
import EZConstraints

protocol BaseEditingHandlers {
    func didTapSaveBtnHandler()
    func updateViewModel()
}

class BaseEditingVC: ViewController, LayoutController, BaseEditingHandlers {

    // MARK: Views
    
    private(set) var hintLabel = Label(text: "Hint",
                                       font: .roundedSystemFont(ofSize: 14, weight: .medium),
                                       color: .secondaryBlackLabel, alignment: .center, numberOfLines: 0)
    private(set) var saveButton = ButtonWithLoadingActivity(title: "SAVE", cornerRadius: 0)
    
    // MARK: Properties
    
    let viewModel: UserViewModel
    var topConstraint: NSLayoutConstraint!
    var hint = "Hint" {
        didSet {
            hintLabel.text = hint
        }
    }
    
    // MARK: Initializers
    
    init(viewModel: UserViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        viewModel = UserViewModel(user: User())
        super.init(coder: coder)
    }
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
        setupActions()
        navigationController?.navigationBar.isHidden = false
        viewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hidesBottomBarWhenPushed = true
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewSafeAreaInsetsDidChange() {
        topConstraint.constant = view.safeAreaInsets.top + 20
    }
    
    // MARK: Setup UI
    
    func setupViews() {
        saveButton.setTitle(.localized(key: "save"), for: .normal)
        view.addSubview(hintLabel)
    }
    
    func setupLayout() {
        topConstraint = hintLabel.layTopToSafeArea(constant: 20)
        hintLabel.edgesToSuperView(including: [.left, .right], insets: .left(40) + .right(40))
    }
    
    func setupActions() {
        saveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
    }
    
    // MARK: Actions
    
    @objc
    private func didTapSaveButton() {
        saveButton.showLoadingIndicator()
        // This trivial delay is made just to have the feel of loading
        // as the request is trivial and doesn't need much time to execute.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.didTapSaveBtnHandler()
        }
    }
    
    func didTapSaveBtnHandler() { }
    
    func updateViewModel() { }
}

// MARK: ViewModel Delegate

extension BaseEditingVC: UserViewModelDelegate {
    func didUpdateUserData(_ error: Error?) {
        saveButton.hideLoadingIndicator()
        if let error = error {
            presentDismissingAlert(title: error.localizedDescription)
        } else {
            updateViewModel()
            let title = String.localizedStringWithFormat(.localized(key: "successful update"), String.localized(key: "profile"))
            let alert = AlertController(title: title, message: "", buttonStackAxis: .horizontal)
            alert.createAlert(title: .localized(key: "okay"), action: .secondary, alertStyle: .cancel) {
                alert.dismiss(animated: true, completion: nil)
                self.navigationController?.popToRootViewController(animated: true)
            }
            present(alert, animated: true, completion: nil)
        }
    }
}
