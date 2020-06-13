//
//  BaseTextFieldEditingVC.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 6/7/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit
import EZConstraints

class BaseTextFieldEditingVC: BaseEditingVC {

    // MARK: Views

    private(set) var textField = TextField(placeholder: "Placeholder", type: .nickname)

    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        hidesBottomBarWhenPushed = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    override func setupViews() {
        super.setupViews()
        view.addSubview(textField)
    }
    
    override func setupLayout() {
        super.setupLayout()
        textField.layBelow(hintLabel, constant: 16)
        textField.edgesToSuperView(including: [.left, .right], insets: .left(16) + .right(16))
        textField.heightAnchor(.equal, constant: 40)
    }
    
    override func setupActions() {
        super.setupActions()
        textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
    }
    
    // MARK: Actions
    
    @objc
    func textFieldEditingChanged() {
        saveButton.isEnabled = (textField.text ?? "").isEmpty || (textField.text ?? "") == textField.placeholder ? false : true
    }
}

extension BaseTextFieldEditingVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.frame = CGRect(origin: .zero, size: CGSize(width: view.bounds.width, height: 44))
        textField.inputAccessoryView = saveButton
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.inputAccessoryView = nil
    }
}
