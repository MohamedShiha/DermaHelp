//
//  FirestoreUserManager.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 6/12/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth
import class GoogleSignIn.GIDGoogleUser

extension FirestoreManager {
    
    typealias UserCompletion = (Result<User,DHError>) -> Void
    
    func usersCollection() -> CollectionReference {
        return fireStore.collection(Paths.users.rawValue)
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
        var profileImage: UIImage?
        if let url = imageUrl, let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
            profileImage = image
        }
        let newUser = User(id: userId, name: fullName, email: email, picture: profileImage, birthDate: nil, gender: nil, assessmentIds: [], updatedAt: Date())
        addUser(newUser)
    }
}
