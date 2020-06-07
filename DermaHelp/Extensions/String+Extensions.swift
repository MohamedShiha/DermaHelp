//
//  String+Extensions.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/15/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

extension String {
    
    func decodeToImage() -> UIImage? {
        let decodedData = Data(base64Encoded: self, options: .ignoreUnknownCharacters)
        guard let data = decodedData else {
            return nil
        }
        return UIImage(data: data)
    }
    
    func usernameFromEmail() -> String {
        let segments = split(separator: "@")
        return segments.count > 1 ? String(segments.first ?? "") : ""
    }
    
    private func evaluate(text: String, by regex: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: text)
    }
    
    func evaluateEmail() -> Bool {
        // This regex matches the string that has at least a character
        // then @ then a character then . then a character,
        // whitespace and special characters are forbidden
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return evaluate(text: self, by: regex)
    }
    
    func evaluatePassword() -> Bool {
        // This regex matches the string that at least contains: 1 digit, 1 uppercase,
        // 1 lowercase letter and 8 characters at least and 24 characters at most,
        // whitespace and special characters are forbidden
        let regex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,24}$"
        return evaluate(text: self, by: regex)
    }
}

extension Array where Element == String {
    var areEmpty: Bool {
        var isEmpty = true
        self.forEach { (string) in
            isEmpty = isEmpty && string.isEmpty
        }
        return isEmpty
    }
    
    var areEqual: Bool {
        var isEqual = true
        for var i in 0..<self.count - 1 {
            isEqual = isEqual && self[i].elementsEqual(self[i+1])
            i += 1
        }
        return isEqual
    }
}
