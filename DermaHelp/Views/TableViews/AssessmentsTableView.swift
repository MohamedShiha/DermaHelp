//
//  AssessmentsTableView.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/9/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

class AssessmentsTableView: UITableView, LayoutController {
    
    // MARK: Initializers
    
    init() {
        super.init(frame: .zero, style: .plain)
        showsVerticalScrollIndicator = false
        separatorStyle = .none
        allowsSelection = false
        register(AssessmentCell.self, forCellReuseIdentifier: AssessmentCell.cellId)
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupViews() {
        backgroundView = EmptyAssessmentsView()
        backgroundView?.isHidden = false
    }
    
    func setupLayout() {
        backgroundView?.center(offset: CGPoint(x: 0, y: -40))
        backgroundView?.aspectRatio(multiplier: 1)
        backgroundView?.widthAnchor(with: self, multiplier: 0.9)
    }
}
