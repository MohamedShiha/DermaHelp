//
//  MyAssessments.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/8/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit
import EZConstraints

class MyAssessmentsVC: ViewController, LayoutController {

    // MARK: Views
    
    private lazy var headingLabel = Label(text: "My Assessments", font: .roundedSystemFont(ofSize: 28, weight: .bold), color: .mainTint)
    private lazy var addButton = AddButton()    
    
    // MARK: Properties
    
    weak var topConstraint: EZConstraint!
    
    // MARK: View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
        setupActions()
    }
    
    override func viewSafeAreaInsetsDidChange() {
        topConstraint.constant = view.safeAreaInsets.top + 24
    }
    
    // MARK: Setup UI
    
    func setupViews() {
        view.addSubViews([headingLabel, addButton])
    }
    
    func setupLayout() {
        topConstraint = headingLabel.layTopInSuperView(constant: 24)
        headingLabel.layLeftInSuperView(constant: 16)
        addButton.layRightInSuperView(constant: 16)
        addButton.alignCenterVertically(with: headingLabel, constant: 0)
        addButton.squareSizeWith(sideLengthOf: 36)
    }
    
    private func setupActions() {
        addButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
    }
    
    // MARK: Actions
    
    @objc
    private func didTapAddButton() {
        // TODO: Present photo importing options
        print("Add")
//        present(, animated: true, completion: nil)
    }
}
