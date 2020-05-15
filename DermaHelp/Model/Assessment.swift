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
        case medium
        case hazardous
    }
    
    let id: String
    let organ: String
    let severity: Severity
    let date: Date
    let riskRate: Float
    let nevusRate: Float
    let melanomaRate: Float
    let colorRate: Float
    let image: UIImage?
    
    enum CodingKeys: String, CodingKey {
        case id, organ = "organName", severity, date,
        riskRate, nevusRate, melanomaRate, colorRate, image
    }
    
    init(id: String, organ: String, severity: Severity, date: Date, riskRate: Float, nevusRate: Float,
         melanomaRate: Float, colorRate: Float, attachedImage: UIImage?) {
        self.id = id
        self.organ = organ
        self.severity = severity
        self.date = date
        self.riskRate = riskRate
        self.nevusRate = nevusRate
        self.melanomaRate = melanomaRate
        self.colorRate = colorRate
        self.image = attachedImage
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        organ = try container.decode(String.self, forKey: .organ)
        severity = try container.decode(Severity.self, forKey: .severity)
        date = try container.decode(String.self, forKey: .date).decodeToDate() ?? Date()
        riskRate = try container.decode(Float.self, forKey: .riskRate)
        nevusRate = try container.decode(Float.self, forKey: .nevusRate)
        melanomaRate = try container.decode(Float.self, forKey: .melanomaRate)
        colorRate = try container.decode(Float.self, forKey: .colorRate)
        image = try container.decode(String.self, forKey: .image).decodeToImage()
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(organ, forKey: .organ)
        try container.encode(severity, forKey: .severity)
        try container.encode(DateFormatter.shortFormat.string(from: date) , forKey: .date)
        try container.encode(riskRate, forKey: .riskRate)
        try container.encode(nevusRate, forKey: .nevusRate)
        try container.encode(melanomaRate, forKey: .melanomaRate)
        try container.encode(colorRate, forKey: .colorRate)
        try container.encode(image?.encodeToBase64(), forKey: .image)
    }
}
