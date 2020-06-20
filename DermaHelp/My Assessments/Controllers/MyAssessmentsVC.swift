//
//  MyAssessments.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/8/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit
import EZConstraints
import LinkPresentation

class MyAssessmentsVC: ViewController, LayoutController {

    // MARK: Views
    
    private let headingLabel = Label(text: "My Assessments", font: .roundedSystemFont(ofSize: 30, weight: .bold), color: .mainTint)
    private let addButton = AddButton()
    private let assessmentsTableView = AssessmentsTableView()
    
    // MARK: Properties
    
    weak var topConstraint: EZConstraint!
    var assessments: Assessments {
        didSet {
            assessments.delegate = self
            assessments.fetch()
        }
    }
    
    init(viewModel: Assessments) {
        assessments = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        assessments = Assessments(userVM: UserViewModel(user: User()))
        super.init(coder: coder)
    }
    
    // MARK: View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
        setupActions()
        assessmentsTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        assessmentsTableView.reloadData()
        assessmentsTableView.handleBackgroundViewIf(emptyCondition: assessments.isEmpty)
    }
    
    override func viewSafeAreaInsetsDidChange() {
        topConstraint.constant = view.safeAreaInsets.top + 24
    }
    
    // MARK: Setup UI
    
    func setupViews() {
        headingLabel.localizingKey = "my assessments"
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
        cell.actionDelegate = self
        cell.assessmentViewModel = assessments[indexPath.row]
        return cell
    }
}

// MARK: Assessments ViewModel Delegate

extension MyAssessmentsVC: AssessmentsViewModelDelegate {
    
    func didFetchAssessments() {
        assessmentsTableView.handleBackgroundViewIf(emptyCondition: assessments.isEmpty)
        if assessmentsTableView.window != nil {
            var indexPaths = [IndexPath]()
            for i in 0..<assessments.count {
                indexPaths.append(IndexPath(row: i, section: 0))
            }
            assessmentsTableView.insertRows(at: indexPaths, with: .top)
        } else {
            assessmentsTableView.reloadData()
        }
    }
    
    func didDeleteAssessment(at index: Int, _ error: Error?) {
        if error == nil {
            assessmentsTableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .fade)
            assessmentsTableView.handleBackgroundViewIf(emptyCondition: assessments.isEmpty)
        } else {
            presentDismissingAlert(title: "Unable to delete the assessment.")
        }
    }
}

// MARK: Cell Delegate

extension MyAssessmentsVC: AssessmentCellDelegate {
    
    func didTapAttachedImage(image: UIImage?) {
        let vc = AttachedImageVC()
        vc.image = image
        let nav = vc.embedInNavigationController()
        present(nav, animated: true, completion: nil)
    }
    
    func didTapShareAction(imageToShare: UIImage?) {
        if let image = imageToShare {
            let activityController = UIActivityViewController(activityItems: [image] as [Any], applicationActivities: nil)
            present(activityController, animated: true, completion: nil)
        }
    }
    
    func didTapDeleteAction(idToDelete: String) {
        let title = "Are you sure you want to delete this assessment?"
        let message = "This action can not be undone."
        presentAlert(title: title, message: message, actionTitle: "Delete", actionType: .primary) {
            self.assessments.deleteAssessment(id: idToDelete)
        }
    }
    
    func presentActionSheet(_ actionSheet: UIAlertController) {
        present(actionSheet, animated: true, completion: nil)
    }
}
