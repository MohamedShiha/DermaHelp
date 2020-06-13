//
//  AttachedImageVC.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 6/10/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

class AttachedImageVC: ViewController, LayoutController {

    // MARK: Views
    
    private let cancelBtn = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didTapCancelBtn))
    private let imageView = UIImageView()
    
    // MARK: Properties
    
    var image: UIImage? {
        set {
            imageView.image = newValue
        }
        get {
            return imageView.image
        }
    }
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Assessment Photo"
        navigationItem.leftBarButtonItem = cancelBtn
        setupViews()
        setupLayout()
    }

    // MARK: Setup UI
    
    func setupViews() {
        view.addSubview(imageView)
    }
    
    func setupLayout() {
        imageView.frame = view.frame
    }
    
    // MARK: Actions
    
    @objc
    private func didTapCancelBtn() {
        dismiss(animated: true, completion: nil)
    }
}
