//
//  ViewController.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/6/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

protocol LayoutController {
    func setupViews()
    func setupLayout()
}

class ViewController: UIViewController {

    // This is not a View Controller that control a specific UI but
    // it will have the standard implementation for every view controller
    // acting as the Base View Controller.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        removeNavigationBackButton()
    }
    
    func embedInNavigationController(hiddenNavBar: Bool = true) -> UINavigationController {
        let navVC = NavigationController(rootViewController: self)
        navVC.navigationBar.isHidden = hiddenNavBar
        return navVC
    }
    
    func removeNavigationBackButton() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
    }
    
    func presentDismissingAlert(title: String, message: String? = nil, dismissingText: String = .localized(key: "try again")) {
        let alert = AlertController.dismissingAlert(title: title, message: message, dismissingTitle: dismissingText)
        present(alert, animated: true, completion: nil)
    }
    
    func presentAlert(title: String, message: String? = nil,
                      buttonsStackAxis axis: NSLayoutConstraint.Axis = .horizontal,
                      actionTitle: String, actionType type: AlertController.Action = .secondary,
                      alertStyle style: UIAlertAction.Style = .cancel, handler: (() -> Void)? = nil) {

        let alert = AlertController.dismissingAlert(title: title, message: message, dismissingTitle: .localized(key: "cancel"))
        alert.buttonStackAxis = axis
        alert.createAlert(title: actionTitle, action: type, alertStyle: style) {
            alert.dismiss(animated: true, completion: nil)
            handler?()
        }
        present(alert, animated: true, completion: nil)
    }
}
