//
//  FirestoreAssessmentsManager.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 6/12/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

extension FirestoreManager {
    
    typealias AssessmentCompletion =  (Result<Assessment,DHError>) -> Void
    typealias AssessmentUpdatingCompletion = (Error?) -> Void
    
    private func assessmentsCollection() -> CollectionReference {
        return fireStore.collection(Paths.assessments.rawValue)
    }
    
    func getAssessmentBy(id: String, _ completion: @escaping AssessmentCompletion) {
        assessmentsCollection().document(id).getDocument { (document, error) in
            guard let document = document, document.exists else {
                completion(.failure(.invalidAssessment))
                return
            }
            let result = Result {
                try document.data(as: Assessment.self)
            }
            switch result {
            case .success(let assessment):
                if let assessment = assessment {
                    completion(.success(assessment))
                } else {
                    print("Document does not exist")
                    completion(.failure(.invalidAssessment))
                }
            case .failure(let error):
                print("Error decoding assessment: \(error)")
                completion(.failure(.invalidAssessment))
            }
        }
    }

    func updateAssessments(userId: String, ids assessmentIds: [String], _ completion: @escaping AssessmentUpdatingCompletion) {
        let key = User.CodingKeys.assessmentIds.rawValue
        let value = assessmentIds
        usersCollection().document(userId).updateData([key:value]) { (error) in
            completion(error)
        }
    }
}
