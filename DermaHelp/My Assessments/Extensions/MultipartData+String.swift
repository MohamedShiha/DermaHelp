//
//  MultipartData+String.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 6/27/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import Foundation

extension Data {
    mutating func append(_ string: String) {
        if let strData = string.data(using: .utf8) {
            append(strData)
        }
    }
}
