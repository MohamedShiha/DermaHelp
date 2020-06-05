//
//  AssessmentCell.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/9/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit
import EZConstraints

class AssessmentCell: UITableViewCell, LayoutController {
    
    // MARK: Views
    
    private lazy var assessmentView = AssessmentView()
    
    // MARK: Properties
    
    static let cellId = "assessments"
    var assessmentViewModel: AssessmentViewModel! {
        didSet {
            assessmentView.organNameLabel.text = assessmentViewModel.organ
            assessmentView.statusView.severity = assessmentViewModel.status
            assessmentView.dateLabel.text = assessmentViewModel.date.formatted
            assessmentView.riskStatusScale.rate = assessmentViewModel.riskRate
            assessmentView.nevusStatusScale.rate = assessmentViewModel.nevusRate
            assessmentView.melanomaStatusScale.rate = assessmentViewModel.melanomaRate
            assessmentView.colorStatusScale.rate = assessmentViewModel.colorRate
            assessmentView.getHelpButton.isHidden = assessmentViewModel.status != .hazardous
        }
    }
    
    // MARK: Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupLayout()
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
}
