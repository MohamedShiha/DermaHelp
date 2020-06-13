//
//  ReauthenticationVC.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 6/8/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit
import EZConstraints

class ReauthenticationVC: BaseReauthenticationVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Password"
        saveButton.setTitle("CONTINUE", for: .normal)
        hint = "To set a new password, please enter your current password first."
    }
    
    override func didReauthenticateWith(_ error: Error?) {
        super.didReauthenticateWith(error)
        if let error = error {
            presentDismissingAlert(title: error.localizedDescription)
        } else {
            navigationController?.pushViewController(NewPasswordEditingVC(viewModel: viewModel), animated: true)
        }
    }
}
