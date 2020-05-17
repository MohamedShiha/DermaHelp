//
//  Data+Extensions.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/16/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import Foundation

extension Data {
    func convertToDictionary() -> [String:Any]? {
        do {
            return try JSONSerialization.jsonObject(with: self, options: .allowFragments) as? [String:Any]
        } catch {
            return nil
        }
    }
}
