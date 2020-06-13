//
//  BasePasswordEditingVC.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 6/8/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit
import EZConstraints

class BasePasswordEditingVC: BaseEditingVC {

    // MARK: Views
    
    private(set) var passwordInputView = PasswordInputView(placeholder: "Password")
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordInputView.textFieldDelegate = self
        hidesBottomBarWhenPushed = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        passwordInputView.textField.becomeFirstResponder()
    }

    // MARK: Setup UI
    
    override func setupViews() {
        super.setupViews()
        view.addSubview(passwordInputView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        passwordInputView.layBelow(hintLabel, constant: 8)
        passwordInputView.edgesToSuperView(including: [.left, .right], insets: .left(16) + .right(16))
        passwordInputView.heightAnchor(.equal, constant: 40)
    }
    
    override func setupActions() {
        super.setupActions()
        passwordInputView.textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
    }
    
    // MARK: Actions
    
    @objc
    func textFieldEditingChanged() {
        saveButton.isEnabled = !(passwordInputView.textField.text ?? "").isEmpty
    }
}

// MARK: Password TextField Delegate

extension BasePasswordEditingVC: PasswordTextFieldDelegate {
    func didTapReturn() {
        print("Did Tap Return")
    }
    
    func didBeginEditing(_ sender: UITextField) {
        saveButton.frame = CGRect(origin: .zero, size: CGSize(width: view.bounds.width, height: 44))
        sender.inputAccessoryView = saveButton
    }
    
    func didEndEditing(_ sender: UITextField) {
        sender.inputAccessoryView = nil
    }
}
