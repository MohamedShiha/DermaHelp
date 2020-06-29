//
//  Assessments.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/10/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

protocol AssessmentsViewModelDelegate: class {
    func didFetchAssessments()
    func didDeleteAssessment(at index: Int, _ error: Error?)
    func didAnalyzeImage(error: Error?)
    func didFinishAssessing(assessment: AssessmentViewModel?)
}

extension AssessmentsViewModelDelegate {
    func didFetchAssessments() { }
    func didDeleteAssessment(at index: Int, _ error: Error?) { }
    func didAnalyzeImage(error: Error?) { }
    func didFinishAssessing(assessment: AssessmentViewModel?) { }
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
    
    func firstIndex(of viewModel: AssessmentViewModel) -> Int? {
        return viewModels.firstIndex(where: { $0.id == viewModel.id })
    }
    
    func fetch() {
        
        let group = DispatchGroup()
        group.enter()
        
        var counter = 1
        DispatchQueue.global(qos: .background).async {
            self.userVM.assessmentIds.forEach { (id) in
                FirestoreManager.shared.getAssessmentBy(id: id) { [weak self] (result) in
                    switch result {
                    case .success(let assessment):
                        self?.viewModels.append(AssessmentViewModel(assessment: assessment))
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                    if counter == self?.userVM.assessmentIds.count {
                        group.leave()
                    }
                    counter += 1
                }
            }
        }
        
        group.notify(queue: .global(qos: .background)) {
            self.viewModels.sort(by: { $0.date.timeIntervalSinceReferenceDate > $1.date.timeIntervalSinceReferenceDate })
            DispatchQueue.main.async {
                 self.delegate?.didFetchAssessments()
            }
        }
    }
    
    private func uploadAssessment(_ assessment: Assessment, _ completion: @escaping (Error?) -> Void) {
        FirestoreManager.shared.uploadAssessment(assessment) { (error) in
            completion(error)
        }
    }
    
    private func updateAssessments(ids: [String], _ completion: @escaping (Error?) -> Void) {
        FirestoreManager.shared.updateAssessments(userId: userVM.id, ids: ids) { (error) in
            completion(error)
        }
    }
    
    func deleteAssessment(id: String) {
        var assessmentIds = userVM.assessmentIds
        if var index = assessmentIds.firstIndex(of: id) {
            assessmentIds.remove(at: index)
            updateAssessments(ids: assessmentIds) { [weak self] (error) in
                if error == nil {
                    self?.userVM.assessmentIds = assessmentIds
                    if let indexToDelete = self?.viewModels.firstIndex(where: { $0.id == id }) {
                        index = indexToDelete
                        self?.viewModels.remove(at: indexToDelete)
                    }
                }
                self?.delegate?.didDeleteAssessment(at: index, error)
            }
        }
    }
    
    private func addAssessment(assessment: Assessment) {
        viewModels.append(AssessmentViewModel(assessment: assessment))
        viewModels.sort(by: { $0.date.timeIntervalSinceReferenceDate > $1.date.timeIntervalSinceReferenceDate })
        userVM.assessmentIds.insert(assessment.id, at: 0)
        updateAssessments(ids: userVM.assessmentIds) { [weak self] (error) in
            if error == nil {
                self?.uploadAssessment(assessment) { (error) in
                    let viewModel = error == nil ? AssessmentViewModel(assessment: assessment) : nil
                    self?.delegate?.didFinishAssessing(assessment: viewModel)
                }
            }
        }
    }
    
    func analyze(image: UIImage) {
        MachineLearningServerAPI.analyze(image: image) { [weak self] (result) in
            switch result {
            case .success(let classified):
                let assessment = Assessment(id: UUID().uuidString, date: Date(), className: classified.className, attachedImage: image)
                self?.addAssessment(assessment: assessment)
                DispatchQueue.main.async {
                    self?.delegate?.didAnalyzeImage(error: nil)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.delegate?.didAnalyzeImage(error: error)
                }
            }
        }
    }
}
