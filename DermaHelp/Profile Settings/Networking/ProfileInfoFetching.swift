//
//  ProfileInfoFetching.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 6/12/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

extension FirestoreManager {
    
    private func getUser(byId id: String, _ completion: @escaping UserCompletion) {
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
    
    private func getAuthenticatedUser(_ completion: @escaping UserCompletion) {
        getUser(byId: Auth.auth().currentUser?.uid ?? "") { (user) in
            completion(user)
        }
    }
    
    func getCurrentUser(_ completion: @escaping UserCompletion) {
        getAuthenticatedUser { (result) in
            completion(result)
        }
    }
}
