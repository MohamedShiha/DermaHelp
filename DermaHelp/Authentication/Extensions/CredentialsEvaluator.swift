//
//  CredentialsEvaluator.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 6/12/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import Foundation

extension NSRegularExpression {
    
    static func evaluate(email: String) -> Bool {
        // This regex matches the string that has at least a character
        // then @ then a character then . then a character,
        // whitespace and special characters are forbidden
        let regex = NSRegularExpression("^(?![.])[A-Z0-9a-z._%+-]{2,64}@[A-Za-z0-9]+?([A-Za-z0-9]|[-.])*?\\.[A-Za-z]{2,24}$")
        return regex.matches(email)
    }
    
    static func evaluate(password: String) -> Bool {
        // This regex matches the string that at least contains: 1 digit, 1 uppercase,
        // 1 lowercase letter and 8 characters at least and 24 characters at most,
        // whitespace and special characters are forbidden
        let regex = NSRegularExpression("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,24}$")
        return regex.matches(password)
    }
}
