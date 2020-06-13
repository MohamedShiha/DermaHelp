//
//  AssessmentsTableView.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/9/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

class AssessmentsTableView: UITableView, LayoutController {
    
    override var backgroundView: UIView? {
        didSet {
            setupLayout()
        }
    }
    
    // MARK: Initializers
    
    init() {
        super.init(frame: .zero, style: .plain)
        showsVerticalScrollIndicator = false
        separatorStyle = .none
        allowsSelection = false
        register(AssessmentCell.self, forCellReuseIdentifier: AssessmentCell.cellId)
        delegate = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupViews() {
        backgroundView = EmptyAssessmentsView()
    }
    
    func setupLayout() {
        backgroundView?.center(offset: CGPoint(x: 0, y: -40))
        backgroundView?.aspectRatio(multiplier: 1)
        backgroundView?.widthAnchor(with: self, multiplier: 0.9)
    }
    
    func handleBackgroundViewIf(emptyCondition: Bool) {
        backgroundView = emptyCondition ? EmptyAssessmentsView() : nil
        isScrollEnabled = !emptyCondition        
    }
}

// MARK: TableView Delegate

extension AssessmentsTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 208
    }
}
