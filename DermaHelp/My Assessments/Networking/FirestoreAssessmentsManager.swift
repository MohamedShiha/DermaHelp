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
    typealias AssessmentOperationCompletion = (Error?) -> Void
    
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
    
    func uploadAssessment(_ assessment: Assessment, _ completion: @escaping AssessmentOperationCompletion) {
        do {
            try assessmentsCollection().document(assessment.id).setData(from: assessment)
            completion(nil)
        } catch let error {
            print("Error writing user to Firestore: \(error)")
            completion(error)
        }
    }

    func updateAssessments(userId: String, ids assessmentIds: [String], _ completion: @escaping AssessmentOperationCompletion) {
        let key = User.CodingKeys.assessmentIds.rawValue
        let value = assessmentIds
        usersCollection().document(userId).updateData([key:value]) { (error) in
            completion(error)
        }
    }
}
