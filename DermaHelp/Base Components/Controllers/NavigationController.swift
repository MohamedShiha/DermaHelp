//
//  NavigationController.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/14/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isHidden = true
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.mainTint]
        navigationBar.tintColor = .mainTint
        view.backgroundColor = .systemBackground
    }
}
