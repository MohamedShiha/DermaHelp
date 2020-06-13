//
//  Assessments.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/10/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import Foundation

protocol AssessmentsViewModelDelegate: class {
    func didFetchAssessments()
    func didDeleteAssessment(at index: Int, _ error: Error?)
}

class Assessments {
    
    private var viewModels = [AssessmentViewModel]()
    private var userVM: UserViewModel
    weak var delegate: AssessmentsViewModelDelegate?
    
    init(userVM: UserViewModel) {
        self.userVM = userVM
    }
    
    subscript(index: Int) -> AssessmentViewModel {
        return viewModels[index]
    }
    
    var isEmpty: Bool {
        return viewModels.isEmpty
    }
    
    var count: Int {
        return viewModels.count
    }
    
    func fetch() {
        
        let group = DispatchGroup()
        group.enter()
        
        var counter = 0
        DispatchQueue.global(qos: .background).async {
            self.userVM.assessmentIds.forEach { (id) in
                FirestoreManager.shared.getAssessmentBy(id: id) { (result) in
                    switch result {
                    case .success(let assessment):
                        self.viewModels.append(AssessmentViewModel(assessment: assessment))
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                    counter += 1
                    group.leave()
                }
            }
        }
        
        group.notify(queue: .global(qos: .background)) {
            if counter == self.userVM.assessmentIds.count {
                DispatchQueue.main.async {
                    self.delegate?.didFetchAssessments()
                }
            }
        }
    }
    
    func deleteAssessment(id: String) {
        var assessmentsId = userVM.assessmentIds
        if let index = assessmentsId.firstIndex(of: id) {
            assessmentsId.remove(at: index)
            FirestoreManager.shared.updateAssessments(userId: userVM.id, ids: assessmentsId) { (error) in
                if error == nil {
                    self.userVM.assessmentIds = assessmentsId
                    self.viewModels.remove(at: index)
                }
                self.delegate?.didDeleteAssessment(at: index, error)
            }
        }
    }
}
