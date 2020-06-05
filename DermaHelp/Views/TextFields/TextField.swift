//
//  TextField.swift
//  Views
//
//  Created by Mohamed Shiha on 5/6/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit
import EZConstraints

class TextField: UITextField {

    // MARK: Properties
    
    private let padding = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
    override var placeholder: String? {
        didSet {
            attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        }
    }
    
    // MARK: Initializers
    
    init(placeholder: String? = nil, type: InputType) {
        super.init(frame: .zero)
        self.placeholder = placeholder
        setupAppearance()
        dropShadow()
        setupTextView(type: type)
        clearButtonMode = .whileEditing
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        return super.clearButtonRect(forBounds: CGRect(x: -8, y: bounds.origin.y, width: bounds.width, height: bounds.height))
    }
    
    // MARK: Padding
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: padding.top, left: padding.left, bottom: padding.bottom, right: padding.right))
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: padding.top, left: padding.left, bottom: padding.bottom, right: padding.right))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: padding.top, left: padding.left, bottom: padding.bottom, right: padding.right))
    }
    
    
    // MARK: Appearance
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 8
        layer.shadowPath = UIBezierPath(rect: CGRect(x: 0, y: 8, width: frame.width, height: frame.height - 4)).cgPath
    }
    
    private func setupAppearance() {
        borderStyle = .none
        textColor = .label
        backgroundColor = .white
    }
    
    private func dropShadow() {
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 6
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
    // MARK: Input type

    private func setupTextView(type: InputType) {
        switch type {
        case .name, .nickname, .firstname, .lastname:
            setupTextFieldContent(type: .name)
        case .location, .country, .city:
            setupTextFieldContent(type: .location)
        case .email:
            autocapitalizationType = .none
            setupTextFieldContent(type: .emailAddress, spellChecking: .no, autocorrection: .no, keyboardType: .emailAddress)
        case .newPassword:
            setupTextFieldContent(type: .newPassword, spellChecking: .no, autocorrection: .no, isMasked: true)
        case .password:
            setupTextFieldContent(type: .password, spellChecking: .no, autocorrection: .no, isMasked: true)
        case .phoneNumber:
            setupTextFieldContent(type: .telephoneNumber, spellChecking: .no, autocorrection: .no, keyboardType: .phonePad)
        case .countryCode:
            setupTextFieldContent(type: .none, spellChecking: .no, autocorrection: .no, keyboardType: .decimalPad)
        default:
            setupTextFieldContent()
        }
    }
    
    private func setupTextFieldContent(type textContent: UITextContentType? = .none, spellChecking: UITextSpellCheckingType = .default, autocorrection: UITextAutocorrectionType = .default, keyboardType: UIKeyboardType = .default, isMasked: Bool = false) {
        textContentType = textContent
        spellCheckingType = spellChecking
        autocorrectionType = autocorrection
        self.keyboardType = keyboardType
        isSecureTextEntry = isMasked
    }

    enum InputType {
        case name, nickname, firstname, lastname
        case location, country, city
        case email
        case newPassword
        case password
        case phoneNumber, countryCode
        case unspecified
    }
}
