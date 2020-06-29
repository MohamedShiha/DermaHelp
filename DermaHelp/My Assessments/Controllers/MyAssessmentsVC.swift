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
    
    private let headingLabel = Label(text: .localized(key: "my assessments"), font: .roundedSystemFont(ofSize: 30, weight: .bold), color: .mainTint)
    private let addButton = PlusButton()
    private let assessmentsTableView = AssessmentsTableView()
    
    // MARK: Properties
    
    weak var topConstraint: EZConstraint!
    var assessments: Assessments {
        didSet {
            assessments.delegate = self
            beginAssessmentVC?.viewModel = assessments
            assessments.fetch()
        }
    }
    var beginAssessmentVC: BeginAssessmentVC?
    private var indexToPresent: Int?
    
    // MARK: Initializers
    
    init(viewModel: Assessments) {
        assessments = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        assessments = Assessments(userVM: UserViewModel(user: User()))
        super.init(coder: coder)
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
        setupActions()
        assessmentsTableView.dataSource = self
        transitioningDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        assessmentsTableView.reloadData()
        assessmentsTableView.handleBackgroundViewIf(emptyCondition: assessments.isEmpty)
        assessments.delegate = self
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
        assessmentsTableView.edgesToSuperView(including: [.left, .bottom, .right], insets: .bottom(8))
    }
    
    private func setupActions() {
        addButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
    }
    
    // MARK: Actions
    
    @objc
    private func didTapAddButton() {
        beginAssessmentVC = BeginAssessmentVC(viewModel: assessments)
        beginAssessmentVC?.modalPresentationStyle = .fullScreen
        if let vc = beginAssessmentVC {
            present(vc, animated: true, completion: nil)
        }
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
            presentDismissingAlert(title: .localized(key: "deleting error"))
        }
    }
    
    func didFinishAssessing(assessment: AssessmentViewModel?) {
        if let viewModel = assessment {
            indexToPresent = 0 // As the new assessment is always added on top
            presentDetailedVC(viewModel: viewModel)
        }
    }
    
    private func presentDetailedVC(viewModel: AssessmentViewModel) {
        let vc = DetailedAssessmentVC(viewModel: viewModel)
        vc.transitioningDelegate = self
        present(vc, animated: true, completion: nil)
    }
}

// MARK: Cell Delegate

extension MyAssessmentsVC: AssessmentCellDelegate {

    func presentDetailedView(viewModel: AssessmentViewModel) {
        presentDetailedVC(viewModel: viewModel)
    }
    
    func didTapShareAction(imageToShare: UIImage?) {
        if let image = imageToShare {
            let activityController = UIActivityViewController(activityItems: [image] as [Any], applicationActivities: nil)
            present(activityController, animated: true, completion: nil)
        }
    }
    
    func didTapDeleteAction(idToDelete: String) {
        let title = String.localized(key: "verify clearing an assessment")
        let message = String.localized(key: "verify clearing an assessment message")
        presentAlert(title: title, message: message, actionTitle: .localized(key: "delete"), actionType: .primary) {
            self.assessments.deleteAssessment(id: idToDelete)
        }
    }
    
    func presentActionSheet(_ actionSheet: UIAlertController) {
        present(actionSheet, animated: true, completion: nil)
    }
    
    func isTappingAssessment(in cell: AssessmentCell) {
        if assessmentsTableView.visibleCells.contains(cell) {
            for i in 0..<assessmentsTableView.visibleCells.count {
                if assessmentsTableView.visibleCells[i] == cell {
                    indexToPresent = i
                } else {
                    UIView.animate(withDuration: 0.2) {
                        self.assessmentsTableView.visibleCells[i].alpha = 0.5
                    }
                }
            }
        }
    }
    
    func didReleaseTap() {
        for cell in assessmentsTableView.visibleCells {
            UIView.animate(withDuration: 0.2) {
                cell.alpha = 1
            }
        }
    }
}

extension MyAssessmentsVC: UIViewControllerTransitioningDelegate {
 
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return customTransition(for: .present)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return customTransition(for: .dismiss)
    }
    
    private func customTransition(for type: CardAnimationController.AnimationType) -> UIViewControllerAnimatedTransitioning? {
        return CardAnimationController(assessmentView: getActiveAssessmentView(), duration: 0.70, type: type)
    }
    
    private func getActiveAssessmentView() -> AssessmentView {
        var assessmentView = AssessmentView()
        if let index = indexToPresent {
            if let view = (assessmentsTableView.visibleCells[index] as? AssessmentCell)?.assessmentView {
                assessmentView = view
            }
        }
        return assessmentView
    }
}
