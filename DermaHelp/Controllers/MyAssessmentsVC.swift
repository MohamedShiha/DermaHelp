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
    
    private lazy var headingLabel = Label(text: "My Assessments", font: .roundedSystemFont(ofSize: 30, weight: .bold), color: .mainTint)
    private lazy var addButton = AddButton()
    private lazy var assessmentsTableView = AssessmentsTableView()
    
    // MARK: Properties
    
    weak var topConstraint: EZConstraint!
    var assessments = Assessments()
    
    // MARK: View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
        setupActions()
        assessmentsTableView.dataSource = self
        assessmentsTableView.handleBackgroundViewIf(assessments.count > 0)
    }
    
    override func viewSafeAreaInsetsDidChange() {
        topConstraint.constant = view.safeAreaInsets.top + 24
    }
    
    // MARK: Setup UI
    
    func setupViews() {
        view.addSubViews([headingLabel, addButton, assessmentsTableView])
    }
    
    func setupLayout() {
        topConstraint = headingLabel.layTopInSuperView(constant: 24)
        headingLabel.layLeftInSuperView(constant: 16)
        addButton.layRightInSuperView(constant: 16)
        addButton.alignCenterVertically(with: headingLabel, constant: 0)
        addButton.squareSizeWith(sideLengthOf: 30)
        assessmentsTableView.layBelow(headingLabel, constant: 16)
        assessmentsTableView.edgesToSuperView(including: [.left, .bottom, .right])
    }
    
    private func setupActions() {
        addButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
    }
    
    // MARK: Actions
    
    @objc
    private func didTapAddButton() {
        let vc = BeginAssessmentVC()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}

// MARK: TableView Delegates

extension MyAssessmentsVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return assessments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AssessmentCell.cellId, for: indexPath) as! AssessmentCell
        cell.assessmentViewModel = assessments[indexPath.row]
        return cell
    }
}
