//
//  SceneDelegate.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/4/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class SceneDelegate: UIResponder, UIWindowSceneDelegate, GIDSignInDelegate {
    
    var window: UIWindow?
    var rootNavigation = RootNavigationController()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        window?.rootViewController = rootNavigation
        setupGoogleSignIn()
        handleUserLoginStatus()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    func setupGoogleSignIn() {
        GIDSignIn.sharedInstance()?.clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }
        
        // Sign in and get user from FireStore, if not, register user in FireStore
        
        let auth = user.authentication
        let credentials = GoogleAuthProvider.credential(withIDToken: auth?.idToken ?? "", accessToken: auth?.accessToken ?? "")
        AuthenticationProvider.shared.continueWithGoogle(authCredentials: credentials) { (error) in
            guard error == nil else { return }
            FirestoreManager.shared.getCurrentUser { (fuser) in
                guard fuser != nil else {
                    FirestoreManager.shared.addUser(user)
                    return
                }
            }
        }
    }    
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        print("User has disconnected google account from the current app.")
    }
    
    func handleUserLoginStatus() {
        AuthenticationProvider.shared.userLoginState { [weak self] (isSignedIn) in
            if isSignedIn {
                self?.rootNavigation.dismiss(animated: true, completion: {
                    self?.rootNavigation.setViewControllers([TabController()], animated: true)
                })
            } else {
                self?.rootNavigation.setViewControllers([SplashScreenVC()], animated: true)
            }
        }
    }
}
