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
