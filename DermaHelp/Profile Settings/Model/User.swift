//
//  User.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/14/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

struct User: Codable {
    
    enum Gender : String, Codable {
        case male = "Male"
        case female = "Female"
    }
    
    let id: String
    var name: String
    var email: String
    var picture: UIImage?
    var birthDate: Date?
    var gender: Gender?
    var assessmentIds: [String]
    let updatedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id, name, email, picture, assessmentIds = "assessments", birthDate, gender, updatedAt
    }
    
    init(id: String, name: String, email: String, picture: UIImage?, birthDate: Date?, gender: Gender?, assessmentIds: [String], updatedAt: Date) {
        self.id = id
        self.name = name
        self.email = email
        self.picture = picture
        self.birthDate = birthDate
        self.gender = gender
        self.assessmentIds = assessmentIds
        self.updatedAt = updatedAt
    }
    
    init() {
        id = ""
        name = ""
        email = ""
        picture = nil
        birthDate = nil
        gender = nil
        assessmentIds = [String]()
        updatedAt = Date()
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        email = try container.decode(String.self, forKey: .email)
        picture = try? container.decode(String.self, forKey: .picture).decodeToImage()
        birthDate = try? container.decode(Date.self, forKey: .birthDate)
        gender = try? container.decode(Gender.self, forKey: .gender)
        updatedAt = try container.decode(Date.self, forKey: .updatedAt)
        var assessmentsContainer = try container.nestedUnkeyedContainer(forKey: .assessmentIds)
        var ids = [String]()
        while !assessmentsContainer.isAtEnd {
            let id = try assessmentsContainer.decode(String.self)
            ids.append(id)
        }
        self.assessmentIds = ids
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(email, forKey: .email)
        try container.encode(picture?.encodeToBase64() ?? nil, forKey: .picture)
        try container.encode(birthDate, forKey: .birthDate)
        try container.encode(gender?.rawValue, forKey: .gender)
        try container.encode(updatedAt, forKey: .updatedAt)
        var assessmentsContainer = container.nestedUnkeyedContainer(forKey: .assessmentIds)
        for id in assessmentIds {
            try assessmentsContainer.encode(id)
        }
    }
}
