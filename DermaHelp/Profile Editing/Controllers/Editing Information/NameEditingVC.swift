//
//  NameEditingVC.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 6/8/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

class NameEditingVC: BaseTextFieldEditingVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = .localized(key: "name")
        textField.placeholder = viewModel.name
        hint = .localized(key: "name hint")
    }
    
    override func didTapSaveBtnHandler() {
        viewModel.updateUser(field: .name, newValue: textField.text ?? "")
    }
    
    override func updateViewModel() {
        viewModel.name = textField.text ?? ""
    }
}
