//
//  Assessments.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/10/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import Foundation

protocol AssessmentsViewModelDelegate: class {
    
}

class Assessments {
    
    private var viewModel = [AssessmentViewModel]()
    private var userVM: UserViewModel
    weak var delegate: AssessmentsViewModelDelegate?
    
    init(userVM: UserViewModel) {
        self.userVM = userVM
    }
    
    subscript(index: Int) -> AssessmentViewModel {
        get {
            return viewModel[index]
        }
    }
    
    var count: Int {
        return viewModel.count
    }
    
    func fetchAssessments(completion: @escaping () -> Void) {
        
        let group = DispatchGroup()
        group.enter()
        
        var counter = 0
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 2) {
            self.userVM.assessmentIds.forEach { (id) in
                FirestoreManager.shared.getAssessmentBy(id: id) { (assessmentResult) in
                    guard let assessment = assessmentResult else { return }
                    self.viewModel.append(AssessmentViewModel(assessment: assessment))
                    counter += 1
                    group.leave()
                }
            }
        }
        
        group.notify(queue: .global(qos: .background)) {
            if counter == self.userVM.assessmentIds.count {
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
}
