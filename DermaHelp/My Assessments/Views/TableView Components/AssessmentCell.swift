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
    func didTapAttachedImage(image: UIImage?)
    func didTapShareAction(imageToShare: UIImage?)
    func didTapDeleteAction(idToDelete: String)
    func presentActionSheet(_ actionSheet: UIAlertController)
}

class AssessmentCell: UITableViewCell, LayoutController {
    
    // MARK: Views
    
    private let assessmentView = AssessmentView()
    
    // MARK: Properties
    
    static let cellId = "assessment"
    weak var actionDelegate: AssessmentCellDelegate?
    var assessmentViewModel: AssessmentViewModel! {
        didSet {
            assessmentView.organNameLabel.text = assessmentViewModel.organ
            assessmentView.statusView.severity = assessmentViewModel.status
            assessmentView.dateLabel.text = assessmentViewModel.date.formatted
            assessmentView.riskStatusScale.rate = assessmentViewModel.riskRate
            assessmentView.nevusStatusScale.rate = assessmentViewModel.nevusRate
            assessmentView.melanomaStatusScale.rate = assessmentViewModel.melanomaRate
            assessmentView.colorStatusScale.rate = assessmentViewModel.colorRate
//            assessmentView.getHelpButton.isHidden = assessmentViewModel.status != .hazardous
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
        assessmentView.edgesToSuperView(insets: .top(8) + .left(16) + .bottom(8) + .right(16))
    }
    
    private func setupLongPressGesture() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(recognizer:)))
        addGestureRecognizer(longPress)
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
        case .ended:
            scaleToIdentity()
            presentAssessmentActions()
        default:
            break
        }
    }
    
    private func presentAssessmentActions() {

        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.view.tintColor = .black
        let attachedPhotoAction = UIAlertAction(title: .localized(key: "attached photo"), style: .default) { [weak self] _ in
            self?.actionDelegate?.didTapAttachedImage(image: self?.assessmentViewModel.attachedImage)
        }
        actionSheet.addAction(attachedPhotoAction)
        
        let shareAction = UIAlertAction(title: .localized(key: "share"), style: .default) { [weak self] _ in
            if let vm = self?.assessmentViewModel {
                self?.actionDelegate?.didTapShareAction(imageToShare: vm.attachedImage)
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
