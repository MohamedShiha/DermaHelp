//
//  ClassifiedCancerClass.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 6/26/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

struct ClassifiedCancerClass: Codable {
    
    let className: ClassIndex
    
    typealias AnalysisHandler = MachineLearningServerAPI.AnalysisCompletion
    
    enum CodingKeys: String, CodingKey {
        case className = "class_name"
    }
    
    enum ClassIndex: String, Codable {
        case actinicKeratoses = "Actinic keratoses"
        case basalCellCarcinoma = "Basal cell carcinoma"
        case benignKeratosisLesion = "Benign keratosis-like lesion"
        case dermatofibroma = "Dermatofibroma"
        case melanocyticNevus = "Melanocytic nevus"
        case vascularLesion = "Vascular lesion"
        case melanoma = "Melanoma"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        var arrayContainer = try container.nestedUnkeyedContainer(forKey: .className)
        self.className = try arrayContainer.decode(ClassIndex.self)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(className, forKey: .className)
    }
}
