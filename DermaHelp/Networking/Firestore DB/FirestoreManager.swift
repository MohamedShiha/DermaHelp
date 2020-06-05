//
//  FirestoreManager.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/16/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth
import GoogleSignIn

class FirestoreManager {
    
    static let shared = FirestoreManager()
    private let fireStore = Firestore.firestore()
    typealias userCompletion = (Result<User,DHError>) -> Void
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
        do {
            try usersCollection().document(user.id).setData(from: user)
        } catch let error {
            print("Error writing user to Firestore: \(error)")
        }
    }
    
    func addUser(_ gmailUser: GIDGoogleUser!) {
        let userId = Auth.auth().currentUser?.uid ?? ""
        let fullName = gmailUser.profile.name ?? ""
        let email = gmailUser.profile.email ?? ""
        let imageUrl = gmailUser.profile.imageURL(withDimension: 200)
        var profileImage: UIImage? = nil
        if let url = imageUrl, let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
            profileImage = image
        }
        let newUser = User(id: userId, name: fullName, email: email, picture: profileImage, birthDate: nil, gender: nil, assessmentIds: [], updatedAt: Date())
        addUser(newUser)
    }
    
    private func getUser(byId id: String, _ completion: @escaping userCompletion) {
        usersCollection().document(id).getDocument { (document, error) in
            guard let document = document, document.exists else {
                completion(.failure(.invalidUsername))
                return
            }
            let result = Result {
                try document.data(as: User.self)
            }
            switch result {
            case .success(let user):
                if let user = user {
                    completion(.success(user))
                } else {
                    print("Document does not exist")
                    completion(.failure(.invalidUsername))
                }
            case .failure(let error):
                print("Error decoding user: \(error)")
                completion(.failure(.invalidUsername))
            }
        }
    }
    
    private func getAuthenticatedUser(_ completion: @escaping userCompletion) {
        getUser(byId: Auth.auth().currentUser?.uid ?? "") { (user) in
            completion(user)
        }
    }
    
    func getCurrentUser(_ completion: @escaping userCompletion) {
        getAuthenticatedUser { (result) in
            completion(result)
        }
    }
    
    func getAssessmentBy(id: String, _ completion: @escaping assessmentCompletion) {
        assessmentsCollection().document(id).getDocument { (document, error) in
            guard let document = document, document.exists else {
                completion(nil)
                return
            }
            let result = Result {
                try document.data(as: Assessment.self)
            }
            switch result {
            case .success(let assessment):
                if let assessment = assessment {
                    completion(assessment)
                } else {
                    print("Document does not exist")
                    completion(nil)
                }
            case .failure(let error):
                print("Error decoding assessment: \(error)")
                completion(nil)
            }
        }
    }
}
