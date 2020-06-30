//
//  AssessmentCell.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/9/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit
import EZConstraints

protocol AssessmentCellDelegate: class {
    func presentDetailedView(viewModel: AssessmentViewModel, sender: AssessmentCell)
    func didTapShareAction(imageToShare: UIImage?)
    func didTapDeleteAction(idToDelete: String)
    func presentActionSheet(_ actionSheet: UIAlertController)
    func isTappingAssessment(in cell: AssessmentCell)
    func didReleaseTap()
}

class AssessmentCell: UITableViewCell, LayoutController {
    
    // MARK: Views
    
    let assessmentView = AssessmentView()
    
    // MARK: Properties
    
    static let cellId = "assessment"
    weak var actionDelegate: AssessmentCellDelegate?
    var assessmentViewModel: AssessmentViewModel! {
        didSet {
            assessmentView.imageView.image = assessmentViewModel.image
            assessmentView.statusView.severity = assessmentViewModel.severity
            assessmentView.dateLabel.text = assessmentViewModel.date.formatted
            assessmentView.riskStatusScale.rate = assessmentViewModel.riskRate
        }
    }
    
    // MARK: Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupLayout()
        setupLongPressGesture()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: Setup UI
    
    func setupViews() {
        contentView.addSubview(assessmentView)
    }
    
    func setupLayout() {
        assessmentView.edgesToSuperView(insets: .top(4) + .left(16) + .bottom(4) + .right(16))
    }
    
    private func setupLongPressGesture() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(recognizer:)))
        assessmentView.addGestureRecognizer(longPress)
    }
    
    private func setupActions() {
        assessmentView.menuButton.addTarget(self, action: #selector(didTapMenuButton), for: .touchUpInside)
    }
    
    // MARK: Actions
    
    @objc
    private func didTapMenuButton() {
        presentAssessmentActions()
    }
    
    @objc
    private func handleLongPress(recognizer: UILongPressGestureRecognizer) {
        switch recognizer.state {
        case .began:
            scaleTo(point: CGPoint(x: 0.95, y: 0.95))
            actionDelegate?.isTappingAssessment(in: self)
        case .ended:
            scaleToIdentity()
            presentDetailedAssessmentVC()
            actionDelegate?.didReleaseTap()
        default:
            break
        }
    }
    
    private func presentDetailedAssessmentVC() {
        actionDelegate?.presentDetailedView(viewModel: assessmentViewModel, sender: self)
    }
    
    private func presentAssessmentActions() {

        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.view.tintColor = .black
        
        let moreInfoAction = UIAlertAction(title: .localized(key: "more info"), style: .default) { [weak self] _ in
            self?.presentDetailedAssessmentVC()
        }
        actionSheet.addAction(moreInfoAction)
        
        let shareAction = UIAlertAction(title: .localized(key: "share"), style: .default) { [weak self] _ in
            if let vm = self?.assessmentViewModel {
                self?.actionDelegate?.didTapShareAction(imageToShare: vm.image)
            }
        }
        actionSheet.addAction(shareAction)
        
        let deleteAction = UIAlertAction(title: .localized(key: "delete"), style: .destructive) { [weak self] _ in
            if let id = self?.assessmentViewModel.id {
                self?.actionDelegate?.didTapDeleteAction(idToDelete: id)
            }
        }
        actionSheet.addAction(deleteAction)
        
        actionSheet.addAction(UIAlertAction(title: .localized(key: "cancel"), style: .cancel, handler: nil))
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            actionSheet.popoverPresentationController?.sourceView = assessmentView.menuButton
            actionSheet.popoverPresentationController?.sourceRect = assessmentView.menuButton.bounds
            actionSheet.popoverPresentationController?.permittedArrowDirections = [.down, .up]
        }
        
        actionDelegate?.presentActionSheet(actionSheet)
    }
}
