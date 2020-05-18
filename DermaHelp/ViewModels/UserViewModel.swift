//
//  UserViewModel.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/16/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

protocol UserViewModelDelegate: class {
    
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
    
    static func fetchCurrentUser(completion: @escaping (_ user: User?) -> Void) {
        FirestoreManager.shared.getCurrentUser { (user) in
            completion(user)
        }
    }
}
