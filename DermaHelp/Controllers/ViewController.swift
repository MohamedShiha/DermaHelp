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
    }
}
