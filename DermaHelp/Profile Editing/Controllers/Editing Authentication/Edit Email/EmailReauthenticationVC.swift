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
        navigationItem.title = "Email"
        saveButton.setTitle("CONFIRM", for: .normal)
        hint = "For your security, please enter your password."
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
