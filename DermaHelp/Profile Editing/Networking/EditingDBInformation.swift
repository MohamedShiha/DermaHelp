//
//  EditingDBInformation.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 6/12/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import Foundation
import FirebaseFirestore

extension FirestoreManager {
    
    typealias DataUpdateCompletion =  (Error?) -> Void
    
    func updateUserData(user: User, _ completion: @escaping DataUpdateCompletion) {
        do {
            try usersCollection().document(user.id).setData(from: user)
            completion(nil)
        } catch let error {
            completion(error)
        }
    }
    
    func updateUser(id: String, field: User.CodingKeys, newValue: Any, _ completion: @escaping DataUpdateCompletion) {
        usersCollection().document(id).updateData([field.rawValue:newValue]) { (error) in
            completion(error)
        }
    }
}
