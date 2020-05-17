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
        case male
        case female
    }
    
    let id: String
    var name: String
    var email: String
    var picture: UIImage?
    var birthDate: Date?
    var gender: Gender?
    var assessments: [Assessment]
    let updatedAt: Date
    
    init(id: String, name: String, email: String, picture: UIImage?, birthDate: Date?, gender: Gender?, assessments: [Assessment], updatedAt: Date) {
        self.id = id
        self.name = name
        self.email = email
        self.picture = picture
        self.birthDate = birthDate
        self.gender = gender
        self.assessments = assessments
        self.updatedAt = updatedAt
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, email, picture, assessments, birthDate, gender, updatedAt
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(email, forKey: .email)
        try container.encode(picture?.encodeToBase64() ?? nil, forKey: .picture)
        try container.encode(birthDate, forKey: .birthDate)
        try container.encode(gender?.rawValue, forKey: .gender)
        try container.encode(DateFormatter.shortFormat.string(from: updatedAt), forKey: .updatedAt)
        var assessmentsContainer = container.nestedUnkeyedContainer(forKey: .assessments)
        for assessment in assessments {
            try assessmentsContainer.encode(assessment)
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        email = try container.decode(String.self, forKey: .email)
        picture = try? container.decode(String.self, forKey: .picture).decodeToImage()
        birthDate = try? container.decode(Date.self, forKey: .birthDate)
        gender = try? container.decode(Gender.self, forKey: .gender)
        updatedAt = try container.decode(String.self, forKey: .updatedAt).decodeToDate() ?? Date()
        var assessmentsContainer = try container.nestedUnkeyedContainer(forKey: .assessments)
        var assessments = [Assessment]()
        while !assessmentsContainer.isAtEnd {
            assessments.append(try assessmentsContainer.decode(Assessment.self))
        }
        self.assessments = assessments
    }
}
