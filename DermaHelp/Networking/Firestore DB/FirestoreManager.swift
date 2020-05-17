//
//  FirestoreManager.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/16/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class FirestoreManager {
    
    static let shared = FirestoreManager()
    private let fireStore = Firestore.firestore()
    typealias userCompletion = (_ user: User?) -> Void
    typealias assessmentCompletion = (_ assessment: Assessment?) -> Void
    typealias assessmentsCompletion = (_ assessment: [Assessment]) -> Void
    
    enum Paths: String {
        case Users
        case Assessments
    }
    
    private func usersCollection() -> CollectionReference {
        return fireStore.collection(Paths.Users.rawValue)
    }
    
    private func assessmentsCollection() -> CollectionReference {
        return fireStore.collection(Paths.Assessments.rawValue)
    }
    
    func addUser(_ user: User) {
        let dictionary = (try? JSONEncoder().encode(user))?.convertToDictionary() ?? [:]
        usersCollection().document(user.id).setData(dictionary)
    }
    
    func getCurrentUser(_ completion: @escaping userCompletion) {
        usersCollection().document(Auth.auth().currentUser?.uid ?? "").getDocument { (document, error) in
            guard let document = document, document.exists, let data = document.data()?.convertToData() else {
                completion(nil)
                return
            }
            guard let user = try? JSONDecoder().decode(User.self, from: data) else {
                completion(nil)
                return
            }
            completion(user)
        }
    }
    
    private func getAssessmentBy(id: String, _ completion: @escaping assessmentCompletion) {
        assessmentsCollection().document(id).getDocument { (document, error) in
            guard let document = document, document.exists, let data = document.data()?.convertToData() else {
                completion(nil)
                return
            }
            guard let assessment = try? JSONDecoder().decode(Assessment.self, from: data) else {
                completion(nil)
                return
            }
            completion(assessment)
        }
    }
    
    func getAssessmentsBy(ids: [String], _ completion: @escaping assessmentsCompletion) {
        ids.forEach { (id) in
            var assessments = [Assessment]()
            getAssessmentBy(id: id) { (assessment) in
                guard let assessment = assessment else { return }
                assessments.append(assessment)
            }
        }
    }
}
