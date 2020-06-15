//
//  AuthenticationProvider.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/12/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import Foundation
import FirebaseAuth
import GoogleSignIn

class AuthenticationProvider {
    
    static let shared = AuthenticationProvider()
    typealias OperationCompletion = (_ error: Error?) -> Void
    typealias UserCompletion = (_ isSignedIn: Bool) -> Void
    
    @discardableResult
    func userLoginState(completion: @escaping UserCompletion) -> AuthStateDidChangeListenerHandle {
        return Auth.auth().addStateDidChangeListener { (_, user) in
            completion(user == nil ? false : true)
        }
    }
}
