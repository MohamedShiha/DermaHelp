//
//  AlertController.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 6/6/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit
import EZConstraints

class AlertController: ViewController, LayoutController {

    enum Action {
        case primary
        case secondary
        case neutral
    }
    
    // MARK: Views

    private let blurView: UIVisualEffectView = {
        let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        effectView.contentView.backgroundColor = UIColor(white: 1, alpha: 0.8)
        effectView.layer.cornerRadius = 16
        effectView.clipsToBounds = true
        return effectView
    }()
    private let titleLabel = Label(text: "Title", font: .roundedSystemFont(ofSize: 19, weight: .bold), alignment: .center, numberOfLines: 0)
    private let bodyLabel = Label(text: "Body", font: .roundedSystemFont(ofSize: 15), alignment: .center, numberOfLines: 0)
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = stackView.axis == .horizontal ? 4 : 8
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    // MARK: Properties
    
    var buttonStackAxis: NSLayoutConstraint.Axis {
        set {
            stackView.axis = newValue
        }
        get {
            return stackView.axis
        }
    }
    private let buttonHeight: CGFloat = 36
    
    // MARK: Initializer
    
    init(title: String, message: String?, buttonStackAxis: NSLayoutConstraint.Axis) {
        super.init(nibName: nil, bundle: nil)
        titleLabel.text = title
        bodyLabel.text = message
        stackView.axis = buttonStackAxis
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
    }
    
    // MARK: Setup UI
    
    func setupViews() {
        view.backgroundColor = UIColor(white: 0, alpha: 0.3)
        view.addSubview(blurView)
        blurView.contentView.addSubViews([titleLabel, bodyLabel, stackView])
    }
    
    func setupLayout() {
        blurView.center()
        blurView.widthAnchor(with: view, multiplier: 0.725)
        [titleLabel, bodyLabel].edgesToSuperView(including: [.left, .right],
                                                 insets: .left(18) + .right(18))
        stackView.edgesToSuperView(including: [.left, .right], insets: .left(16) + .right(16))
        titleLabel.layTopInSuperView(constant: 20)
        bodyLabel.layBelow(titleLabel, constant: 6)
        stackView.layBelow(bodyLabel, constant: 12)
        stackView.layBottomInSuperView(constant: 12)
        if stackView.axis == .horizontal {
            stackView.heightAnchor(.equal, constant: buttonHeight)
        }
    }
    
    private func alertButtonFactory(title: String, alertStyle: UIAlertAction.Style, action: Action) -> Button {
        var weight: UIFont.Weight = .regular
        var color = UIColor.black
        var backColor = UIColor.clear
        switch alertStyle {
        case .cancel:
            weight = .semibold
        case .destructive:
            backColor = .systemRed
        default:
            weight = .regular
        }
        switch action {
        case .primary:
            backColor = .mainTint
            color = .white
        case .secondary:
            backColor = .systemFill
        default:
            backColor = .clear
        }
        let button = Button(title: title, font: .roundedSystemFont(ofSize: 17, weight: weight), titleColor: color, backColor: backColor)
        button.layer.cornerRadius = 16
        return button
    }
    
    // MARK: Adding Alerts
    
    func createAlert(title: String, action: Action, alertStyle: UIAlertAction.Style, handler: (() -> Void)? = nil) {
        let button = alertButtonFactory(title: title, alertStyle: alertStyle, action: action)
        if stackView.axis == .vertical {
            button.heightAnchor(.equal, constant: buttonHeight)
        }
        if stackView.axis == .horizontal {
            stackView.addArrangedSubview(button)
        } else if stackView.axis == .vertical {
            stackView.insertArrangedSubview(button, at: 0)
        }
        if stackView.arrangedSubviews.count > 1 {
            if stackView.axis == .horizontal {
                stackView.arrangedSubviews.first?.backgroundColor = .clear
            } else if stackView.axis == .vertical {
                stackView.arrangedSubviews.last?.backgroundColor = .clear
            }
        }
        button.didTapButton = { (sender) in
            handler?()
        }
    }
    
    class func dismissingAlert(title: String, message: String?,
                               axis: NSLayoutConstraint.Axis = .horizontal,
                               dismissingTitle: String) -> AlertController {
        let alertController = AlertController(title: title, message: message, buttonStackAxis: axis)
        alertController.createAlert(title: dismissingTitle, action: .secondary, alertStyle: .cancel) {
            alertController.dismiss(animated: true, completion: nil)
        }
        return alertController
    }
}
