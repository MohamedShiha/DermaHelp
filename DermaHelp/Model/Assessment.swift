//
//  Assessment.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/10/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import struct Foundation.Date
import class UIKit.UIImage

struct Assessment {
    
    enum Status: String {
        case low = "Low"
        case medium = "Medium"
        case hazardous = "Hazardous"
    }
    
    let organ: String
    let status: Status
    let date: Date
    let riskRate: Float
    let nevusRate: Float
    let melanomaRate: Float
    let colorRate: Float
    let attachedImage: UIImage?
}
