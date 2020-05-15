//
//  AuthenticationProvider.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/12/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import Foundation
import FirebaseAuth

class AuthenticationProvider {
    
    static let shared = AuthenticationProvider()
    typealias authCompletion = (_ error: Error?) -> Void
    typealias signOutCompletion = (_ success: Bool) -> Void
    typealias userCompletion = (_ isSignedIn: Bool) -> Void
    
    @discardableResult
    func userLoginState(completion: @escaping userCompletion) -> AuthStateDidChangeListenerHandle {
        return Auth.auth().addStateDidChangeListener { (auth, user) in
            if user == nil {
                completion(false)
            } else {
                // TODO: Load from FireStore
                completion(true)
            }
        }
    }
    
    func login(withEmail email: String, password: String, _ completion: @escaping authCompletion) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            guard error == nil else {
                completion(error)
                return
            }
            completion(nil)
        }
    }
    
    func signUp(withEmail email: String, password: String, _ completion: @escaping authCompletion) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            guard let result = result else {
                completion(error)
                return
            }
            let authUser = result.user
            let user = User(id: authUser.uid, name: authUser.email?.usernameFromEmail() ?? "", picture: nil, birthDate: nil, gender: nil, assessments: [], updatedAt: Date())
            // TODO: Save to FireStore
            completion(nil)
        }
    }
    
    func signOut(_ completion: @escaping signOutCompletion) {
        
        if GoogleAuthProvider.isSignedInWithGoogle {
            GoogleAuthProvider.signOut()
            completion(true)
        } else {
            do {
                try Auth.auth().signOut()
                // Completion is handled by SceneDelegate by a state listener.
            } catch let error as NSError {
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
}
