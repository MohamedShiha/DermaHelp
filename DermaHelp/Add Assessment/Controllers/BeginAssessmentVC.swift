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
    
    private let headingLabel = Label(text: .localized(key: "begin assessment"), font: .roundedSystemFont(ofSize: 30, weight: .bold), color: .mainTint)
    private let dismissButton = PlusButton()
    private let manualView = ManualView()
    private let cameraButton = MediaOptionButton(image: UIImage(systemName: "camera.fill"), title: .localized(key: "take photo"))
    private let libraryButton = MediaOptionButton(image: UIImage(systemName: "photo"), title: .localized(key: "choose photo"))
    private var loadingView: LoadingView?
    
    // MARK: Properties
    
    var imagePicker: ImagePicker!
    weak var topConstraint: EZConstraint!
    var viewModel: Assessments
    
    // MARK: Initializers
    
    init(viewModel: Assessments) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        viewModel = Assessments(userVM: UserViewModel(user: User()))
        super.init(coder: coder)
    }
    
    // MARK: View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
        setupActions()
        imagePicker = ImagePicker(presentationController: self, delegate: self)
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
    
    private func showLoadingIndicator() {
        loadingView = LoadingView()
        view.addSubview(loadingView!)
        loadingView?.squareSizeWith(sideLengthOf: 70)
        loadingView?.center()
        loadingView?.startLoading()
    }
    
    private func hideLoadingIndicator() {
        if loadingView != nil {
            loadingView?.stopLoading()
            loadingView = nil
        }
    }
    
    // MARK: Actions
    
    @objc
    private func didTapDismissButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc
    private func didTapCameraButton() {
        imagePicker.presentCamera()
    }
    
    @objc
    private func didTapLibraryButton() {
        imagePicker.presentPhotoLibrary()
    }
}

// MARK: ViewModel Delegate

extension BeginAssessmentVC: AssessmentsViewModelDelegate {
    func didAnalyzeImage(error: Error?) {
        hideLoadingIndicator()
        if error == nil {
            dismiss(animated: true, completion: nil)
        } else {
            presentDismissingAlert(title: .localized(key: "analyzing error"))
        }
    }
}

// MARK: ImagePicker Delegate

extension BeginAssessmentVC: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        if let image = image {
            showLoadingIndicator()
            viewModel.analyze(image: image)
        }
    }
}
