//
//  PasswordRulesEvaluator.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 6/12/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import Foundation

extension NSRegularExpression {
    
    static func containsADigit(string: String) -> Bool {
        // This regex matches the string that at least contains 1 digit
        let regex = NSRegularExpression(".*[0-9]+.*")
        return regex.matches(string)
    }
    
    static func containsAnUpperCase(string: String) -> Bool {
        // This regex matches the string that at least contains 1 upper case
        let regex = NSRegularExpression(".*[A-Z]+.*")
        return regex.matches(string)
    }
    
    static func containsASpecialChar(string: String) -> Bool {
        // This regex matches the string that at least contains 1 special character
        let regex = NSRegularExpression(".*[!&^%$#@()/:;<>.,?|\"' ]+.*")
        return regex.matches(string)
    }
}
