//
//  PasswordInputView.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/6/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

protocol PasswordTextFieldDelegate: class {
    func didBeginEditing(_ sender: UITextField)
    func didEndEditing(_ sender: UITextField)
    func didTapReturn(_ sender: UITextField)
}

extension PasswordTextFieldDelegate {
    func didBeginEditing(_ sender: UITextField) { }
    func didEndEditing(_ sender: UITextField) { }
    func didTapReturn(_ sender: UITextField) { }
}

class PasswordInputView: UIView, LayoutController {
    
    private let showButton = Button(title: "show", font: .roundedSystemFont(ofSize: 15),titleColor: .mainTint)
    let textField: TextField
    weak var textFieldDelegate: PasswordTextFieldDelegate?
    
    init(placeholder: String = "Password") {
        textField = TextField(placeholder: placeholder, type: .password)
        super.init(frame: .zero)
        setupViews()
        setupLayout()
        showButton.addTarget(self, action: #selector(didTapShowButton), for: .touchUpInside)
        textField.delegate = self
        showButton.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        textField = TextField(placeholder: "Password", type: .password)
        super.init(coder: coder)
    }
    
    func setupViews() {
        addSubViews([textField, showButton])
    }
    
    func setupLayout() {
        textField.edgesToSuperView()
        showButton.centerVertically()
        showButton.layRightInSuperView(constant: 36)
    }
    
    @objc
    private func didTapShowButton() {
        textField.isSecureTextEntry = !textField.isSecureTextEntry
        showButton.setTitle(textField.isSecureTextEntry ? "show" : "hide", for: .normal)
    }
    
    private func setStateToDefault() {
        textField.isSecureTextEntry = true
        showButton.setTitle("show", for: .normal)
    }
}

extension PasswordInputView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        showButton.isHidden = false
        setStateToDefault()
        textFieldDelegate?.didBeginEditing(textField)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        showButton.isHidden = true
        setStateToDefault()
        textFieldDelegate?.didEndEditing(textField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textFieldDelegate?.didTapReturn(textField)
        return true
    }
}
