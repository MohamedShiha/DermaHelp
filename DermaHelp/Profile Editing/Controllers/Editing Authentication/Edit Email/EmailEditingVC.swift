//
//  EmailEditingVC.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 6/8/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

class EmailEditingVC: BaseTextFieldEditingVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = .localized(key: "email address")
        textField.placeholder = viewModel.email
        saveButton.setTitle(.localized(key: "continue"), for: .normal)
        hint = .localized(key: "email hint")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didTapSaveBtnHandler() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
            if NSRegularExpression.evaluate(email: self.textField.text ?? "") {
                let vc = EmailReauthenticationVC(viewModel: self.viewModel)
                vc.email = self.textField.text ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                self.presentDismissingAlert(title: .localized(key: "invalid email"))
            }
            self.saveButton.hideLoadingIndicator()
        }
    }
}
