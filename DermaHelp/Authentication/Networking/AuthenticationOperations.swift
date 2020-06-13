//
//  AuthenticationOperations.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 6/12/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import Foundation
import FirebaseAuth
import GoogleSignIn

extension AuthenticationProvider {
    
    func continueWithGoogle(user: GIDGoogleUser!, _ completion: @escaping OperationCompletion) {
        let authCredentials = GoogleAuthenticationProvider.credential(authentication: user.authentication)
        Auth.auth().signIn(with: authCredentials) { (_, error) in
            guard error == nil else {
                completion(error)
                return
            }
            completion(nil)
        }
    }
    
    func login(withEmail email: String, password: String, _ completion: @escaping OperationCompletion) {
        Auth.auth().signIn(withEmail: email, password: password) { (_, error) in
            guard error == nil else {
                completion(error)
                return
            }
            completion(nil)
        }
    }
    
    func signUp(withEmail email: String, password: String, _ completion: @escaping OperationCompletion) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            guard let result = result else {
                completion(error)
                return
            }
            let authUser = result.user
            let user = User(id: authUser.uid, name: authUser.email?.usernameFromEmail() ?? "",
                            email: authUser.email ?? "", picture: nil, birthDate: nil,
                            gender: nil, assessmentIds: [], updatedAt: Date())
            FirestoreManager.shared.addUser(user)
            completion(nil)
        }
    }
    
    func logOut(_ completion: @escaping OperationCompletion) {
        if GoogleAuthenticationProvider.isSignedInWithGoogle {
            GoogleAuthenticationProvider.signOut()
        }
        do {
            try Auth.auth().signOut()
            // Completion is handled by SceneDelegate by a state listener.
        } catch let error as NSError {
            completion(error)
        }
    }
    
    func reauthenticate(with oldPassword: String, _ completion: @escaping OperationCompletion) {
        let currentUser = Auth.auth().currentUser
        let credentials = FirebaseAuth.EmailAuthProvider.credential(withEmail: currentUser?.email ?? "", password: oldPassword)
        currentUser?.reauthenticate(with: credentials, completion: { (_, error) in
            completion(error)
        })
    }
}
