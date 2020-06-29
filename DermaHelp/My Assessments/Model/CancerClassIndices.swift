//
//  CancerClass.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 6/27/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import Foundation

struct CancerClass {
    let name: ClassifiedCancerClass.ClassIndex
    let severity: Assessment.Severity
    let riskRate: Float
    let awarenessText:String
}

typealias ClassName = ClassifiedCancerClass.ClassIndex

let cancerClassDictionary: [ClassName:CancerClass] = [
    .actinicKeratoses: CancerClass(name: .actinicKeratoses,
                                   severity: .lowMedium,
                                   riskRate: 40,
                                   awarenessText: .localized(key: ClassName.actinicKeratoses.rawValue + " awareness")
    ),
    .basalCellCarcinoma: CancerClass(name: .basalCellCarcinoma,
                                     severity: .highMedium,
                                     riskRate: 80,
                                     awarenessText: .localized(key: ClassName.basalCellCarcinoma.rawValue + " awareness")
    ),
    .benignKeratosisLesion: CancerClass(name: .benignKeratosisLesion,
                                        severity: .low,
                                        riskRate: 20,
                                        awarenessText: .localized(key: ClassName.benignKeratosisLesion.rawValue + " awareness")
    ),
    .dermatofibroma: CancerClass(name: .dermatofibroma,
                                 severity: .low,
                                 riskRate: 20,
                                 awarenessText: .localized(key: ClassName.dermatofibroma.rawValue + " awareness")
    ),
    .melanocyticNevus: CancerClass(name: .melanocyticNevus,
                                   severity: .lowMedium,
                                   riskRate: 40,
                                   awarenessText: .localized(key: ClassName.melanocyticNevus.rawValue + " awareness")
    ),
    .melanoma: CancerClass(name: .melanoma,
                           severity: .hazardous,
                           riskRate: 100,
                           awarenessText: .localized(key: ClassName.melanoma.rawValue + " awareness")
    ),
    .vascularLesion: CancerClass(name: .vascularLesion,
                                 severity: .medium,
                                 riskRate: 60,
                                 awarenessText: .localized(key: ClassName.vascularLesion.rawValue + " awareness")
    )
]
