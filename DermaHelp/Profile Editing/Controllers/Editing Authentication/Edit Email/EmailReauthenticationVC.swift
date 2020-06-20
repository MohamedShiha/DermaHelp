//
//  EmailReauthenticationVC.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 6/9/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

class EmailReauthenticationVC: BaseReauthenticationVC {
    
    var email = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = .localized(key: "email address")
        saveButton.setTitle(.localized(key: "confirm"), for: .normal)
        hint = .localized(key: "auth hint")
    }
    
    override func updateViewModel() {
        viewModel.email = email
    }
    
    override func didReauthenticateWith(_ error: Error?) {
        super.didReauthenticateWith(error)
        if let error = error {
            self.presentDismissingAlert(title: error.localizedDescription)
        } else {
            viewModel.updateEmail(email.lowercased()) { [weak self] (error) in
                if let error = error {
                    self?.presentDismissingAlert(title: error.localizedDescription)
                } else {
                    // If changing email succeeded, it will be reflected in the database
                    // automatically didUpdateUserData(_ : Error?) will be called to
                    // handle updating the viewModel and navigation.
                }
            }
        }
    }
}
