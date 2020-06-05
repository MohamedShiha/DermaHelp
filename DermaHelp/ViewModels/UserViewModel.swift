//
//  UserViewModel.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/16/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

protocol UserViewModelDelegate: class {
    func didFetchUser()
    func failedToFetchUser(with error: String)
}

class UserViewModel {
    
    private var user: User
    weak var delegate: UserViewModelDelegate?
    
    init(user: User) {
        self.user = user
    }
    
    var id: String {
        return user.id
    }
    
    var name: String {
        set {
            user.name = newValue
        }
        get {
            return user.name
        }
    }
    
    var email: String {
        set {
            user.email = newValue
        }
        get {
            return user.email
        }
    }
    
    var picture: UIImage? {
        set {
            user.picture = newValue
        }
        get {
            return user.picture
        }
    }
    
    var birthDate: Date? {
        set {
            user.birthDate = newValue
        }
        get {
            return user.birthDate
        }
    }
    
    var gender: User.Gender? {
        set {
            user.gender = newValue
        }
        get {
            return user.gender
        }
    }
    
    var assessmentIds: [String] {
        set {
            user.assessmentIds = newValue
        }
        get {
            return user.assessmentIds
        }
    }
    
    var updatedAt: Date {
        return user.updatedAt
    }
    
    func fetchCurrentUser() {
        FirestoreManager.shared.getCurrentUser { [weak self] result in
            switch result {
            case .success(let user):
                self?.user = user
                self?.delegate?.didFetchUser()
            case .failure(let error):
                self?.delegate?.failedToFetchUser(with: error.rawValue)
                break
            }
        }
    }
}
