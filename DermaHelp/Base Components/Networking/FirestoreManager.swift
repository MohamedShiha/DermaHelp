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
import class GoogleSignIn.GIDGoogleUser

class FirestoreManager {
    
    static let shared = FirestoreManager()
    internal let fireStore = Firestore.firestore()
    
    enum Paths: String {
        case users = "Users"
        case assessments = "Assessments"
    }
}
