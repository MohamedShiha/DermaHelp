//
//  BeginAssessmentVC.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/10/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit
import EZConstraints

class BeginAssessmentVC: ViewController, LayoutController {
    
    // MARK: Views
    
    private lazy var headingLabel = Label(text: "Begin Assessment", font: .roundedSystemFont(ofSize: 30, weight: .bold), color: .mainTint)
    private lazy var dismissButton = AddButton()
    private lazy var manualView = ManualView()
    private lazy var cameraButton = MediaOptionButton(image: UIImage(systemName: "camera.fill"), title: "Take Photo")
    private lazy var libraryButton = MediaOptionButton(image: UIImage(systemName: "photo"), title: "Choose Photo")
    
    // MARK: Properties
    
    weak var topConstraint: EZConstraint!
    
    // MARK: View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
        setupActions()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        dismissButton.animateRotation()
    }
    
    override func viewSafeAreaInsetsDidChange() {
        topConstraint.constant = view.safeAreaInsets.top + 24
    }
    
    // MARK: Setup UI
    
    func setupViews() {
        view.addSubViews([
            headingLabel, dismissButton, manualView,
            cameraButton, libraryButton
        ])
    }
    
    func setupLayout() {
        
        topConstraint = headingLabel.layTopInSuperView(constant: 24)
        headingLabel.layLeftInSuperView(constant: 16)
        
        dismissButton.layRightInSuperView(constant: 16)
        dismissButton.alignCenterVertically(with: headingLabel, constant: 0)
        dismissButton.squareSizeWith(sideLengthOf: 30)
        
        manualView.layBelow(headingLabel, constant: 40)
        
        [manualView, cameraButton,
         libraryButton].edgesToSuperView(including: [.left, .right], insets: .left(16) + .right(16))
        
        cameraButton.layBelow(manualView, constant: 24)
        libraryButton.layBelow(cameraButton, constant: 16)
        [cameraButton, libraryButton].heightAnchor(.equal, constant: 40)
    }
    
    private func setupActions() {
        dismissButton.addTarget(self, action: #selector(didTapDismissButton), for: .touchUpInside)
        cameraButton.addTarget(self, action: #selector(didTapCameraButton), for: .touchUpInside)
        libraryButton.addTarget(self, action: #selector(didTapLibraryButton), for: .touchUpInside)
    }
    
    // MARK: Actions
    
    @objc
    private func didTapDismissButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc
    private func didTapCameraButton() {
        // TODO: Present camera
        print("Camera")
    }
    
    @objc
    private func didTapLibraryButton() {
        // TODO: Present Library
        print("Photo Library")
    }
}

