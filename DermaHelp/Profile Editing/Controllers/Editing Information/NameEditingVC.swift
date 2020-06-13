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
        navigationItem.title = "Name"
        textField.placeholder = viewModel.name
        hint = "This is how you appear on DermaHelp. This name is private and will not be shared among other users neither used in medical analysis."
    }
    
    override func didTapSaveBtnHandler() {
        viewModel.updateUser(field: .name, newValue: textField.text ?? "")
    }
    
    override func updateViewModel() {
        viewModel.name = textField.text ?? ""
    }
}
