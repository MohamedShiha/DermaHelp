//
//  UserViewModel+Updating.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 6/13/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

extension UserViewModel {
   
    func updateUserData() {
        FirestoreManager.shared.updateUserData(user: user) { (error) in
            self.delegate?.didUpdateUserData(error)
        }
    }
    
    func updateUser(field: User.CodingKeys, newValue: Any) {
        if let image = newValue as? UIImage {
            let base64Str = image.encodeToBase64()
            performUpdate(field: .picture, newValue: base64Str) { (error) in
                self.delegate?.didUpdateUserData(error)
            }
        } else {
            performUpdate(field: field, newValue: newValue) { (error) in
                self.delegate?.didUpdateUserData(error)
            }
        }
    }
    
    private func performUpdate(field: User.CodingKeys, newValue: Any, _ completion: @escaping (Error?) -> Void) {
        FirestoreManager.shared.updateUser(id: id, field: field, newValue: newValue) { (error) in
            completion(error)
        }
    }
    
    func updateEmail(_ email: String, _ completion: @escaping (_ error: Error?) -> Void) {
        self.email = email
        AuthenticationProvider.shared.updateEmail(email) { [weak self] (error) in
            if error == nil, let viewModel = self {
                FirestoreManager.shared.updateUserData(user: viewModel.user) { (updatingError) in
                    self?.delegate?.didUpdateUserData(updatingError)
                }
            } else {
                completion(error)
            }
        }
    }
    
    func reauthenticate(with oldPassword: String, _ completion: @escaping (_ error: Error?) -> Void) {
        AuthenticationProvider.shared.reauthenticate(with: oldPassword) { (error) in
            completion(error)
        }
    }
    
    func updatePassword(_ password: String, _ completion: @escaping (_ error: Error?) -> Void) {
        AuthenticationProvider.shared.updatePassword(password) { (error) in
            completion(error)
        }
    }

}
