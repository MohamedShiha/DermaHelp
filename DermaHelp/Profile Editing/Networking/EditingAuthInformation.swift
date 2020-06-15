//
//  EditingAuthInformation.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 6/12/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import Foundation
import FirebaseAuth
import GoogleSignIn

extension AuthenticationProvider {
    
    func updateEmail(_ email: String, _ completion: @escaping OperationCompletion) {
        let currentUser = Auth.auth().currentUser
        currentUser?.updateEmail(to: email, completion: { (error) in
            completion(error)
        })
    }
    
    func updatePassword(_ password: String, _ completion: @escaping OperationCompletion) {
        let currentUser = Auth.auth().currentUser
        currentUser?.updatePassword(to: password, completion: { (error) in
            completion(error)
        })
    }
}
