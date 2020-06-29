//
//  Assessment.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/10/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

struct Assessment: Codable {
    
    enum Severity: String, Codable {
        case low
        case lowMedium = "low medium"
        case medium
        case highMedium = "high medium"
        case hazardous
    }
    
    let id: String
    let className: ClassifiedCancerClass.ClassIndex
    let severity: Severity
    let riskRate: Float
    let date: Date
    let image: UIImage
    
    enum CodingKeys: String, CodingKey {
        case id, className = "class_name", severity, date,
        riskRate, image
    }
    
    init(id: String, date: Date, className: ClassifiedCancerClass.ClassIndex, attachedImage: UIImage) {
        self.id = id
        self.date = date
        self.image = attachedImage
        self.className = className
        let cancerClass = cancerClassDictionary[className]
        riskRate = cancerClass?.riskRate ?? 0
        severity = cancerClass?.severity ?? .low
    }
    
    init() {
        id = ""
        className = .actinicKeratoses
        severity = .low
        riskRate = 0
        date = Date()
        image = UIImage()
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        className = try container.decode(ClassifiedCancerClass.ClassIndex.self, forKey: .className)
        severity = try container.decode(Severity.self, forKey: .severity)
        riskRate = try container.decode(Float.self, forKey: .riskRate)
        date = try container.decode(Date.self, forKey: .date)
        image = try container.decode(String.self, forKey: .image).decodeToImage() ?? UIImage()
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(className, forKey: .className)
        try container.encode(severity, forKey: .severity)
        try container.encode(date , forKey: .date)
        try container.encode(riskRate, forKey: .riskRate)
        try container.encode(image.encodeToBase64(), forKey: .image)
    }
}
