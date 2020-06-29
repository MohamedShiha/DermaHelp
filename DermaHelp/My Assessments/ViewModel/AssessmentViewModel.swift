//
//  AssessmentViewModel.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/10/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import struct Foundation.Date
import class UIKit.UIImage

class AssessmentViewModel {
    
    private var assessment: Assessment
    
    init(assessment: Assessment) {
        self.assessment = assessment
    }
    
    var id: String {
        return assessment.id
    }
    
    var className: ClassifiedCancerClass.ClassIndex {
        return assessment.className
    }
    
    var severity: Assessment.Severity {
        return assessment.severity
    }
    
    var riskRate: Float {
        return assessment.riskRate
    }
    
    var date: Date {
        return assessment.date
    }
    
    var image: UIImage {
        return assessment.image
    }
}
