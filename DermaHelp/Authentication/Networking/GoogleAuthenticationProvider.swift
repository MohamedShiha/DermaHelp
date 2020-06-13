//
//  GoogleAuthProvider.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/14/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import Foundation
import GoogleSignIn
import FirebaseAuth

class GoogleAuthenticationProvider {
    
    static var isSignedInWithGoogle: Bool {
        return GIDSignIn.sharedInstance()?.currentUser != nil
    }
    
    static func credential(authentication: GIDAuthentication?) -> AuthCredential {
        GoogleAuthProvider.credential(withIDToken: authentication?.idToken ?? "", accessToken: authentication?.accessToken ?? "")
    }
    
    static func signIn() {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    static func signOut() {
        GIDSignIn.sharedInstance()?.signOut()
    }
}
