//
//  Assessments.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/10/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import Foundation

struct Assessments {
    
    private let modelViews = [AssessmentViewModel]()
    
    subscript(index: Int) -> AssessmentViewModel {
        get {
            return modelViews[index]
        }
    }
    
    var count: Int {
        return modelViews.count
    }
}
