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
        navigationItem.title = .localized(key: "password")
        saveButton.setTitle(.localized(key: "continue"), for: .normal)
        hint = .localized(key: "password auth hint")
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
