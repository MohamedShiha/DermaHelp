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
    
    func decodeToDate() -> Date? {
        return DateFormatter.shortFormat.date(from: self)
    }
    
    func usernameFromEmail() -> String {
        let segments = split(separator: "@")
        return segments.count > 1 ? String(segments.first ?? "") : ""
    }
}
