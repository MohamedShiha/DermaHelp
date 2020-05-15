//
//  AssessmentViewModel.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/10/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import struct Foundation.Date
import class UIKit.UIImage

protocol AssessmentViewModelDelegate: class {
    
}

protocol AssessmentModelViewType {
    init(assessment: Assessment)
    var organ: String { get }
    var status: Assessment.Severity { get }
    var date: Date { get }
    var riskRate: Float { get }
    var nevusRate: Float { get }
    var melanomaRate: Float { get }
    var colorRate: Float { get }
    var attachedImage: UIImage? { get }
}

class AssessmentViewModel: AssessmentModelViewType {
    
    private var assessment: Assessment
    weak var delegate: AssessmentViewModelDelegate?
    
    required init(assessment: Assessment) {
        self.assessment = assessment
    }
    
    var id: String {
        return assessment.id
    }
    
    var organ: String {
        return assessment.organ
    }
    
    var status: Assessment.Severity {
        return assessment.severity
    }
    
    var date: Date {
        return assessment.date
    }
    
    var riskRate: Float {
        return assessment.riskRate
    }
    
    var nevusRate: Float {
        return assessment.nevusRate
    }
    
    var melanomaRate: Float {
        return assessment.melanomaRate
    }
    
    var colorRate: Float {
        return assessment.colorRate
    }
    
    var attachedImage: UIImage? {
        return assessment.image
    }
}
