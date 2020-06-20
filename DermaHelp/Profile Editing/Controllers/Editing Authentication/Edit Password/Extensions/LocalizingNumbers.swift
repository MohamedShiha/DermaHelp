//
//  LocalizingNumbers.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 6/20/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import Foundation

extension Int {
    func localized() -> String {
        return NumberFormatter().string(from: NSNumber(value: self)) ?? ""
    }
}
