//
//  Date+Extension.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/10/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import Foundation

extension Date {
    var formatted: String {
        return DateFormatter.shortFormat.string(from: self)
    }
}

extension DateFormatter {
    static var shortFormat: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d/M/yyyy"
        return dateFormatter
    }
}
