//
//  Features.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/6/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

// This is a fixed list of the features displayed in the splash screen

struct Features {
 
    static let list: [(image: UIImage?, name: String)] = [
        (image: UIImage(systemName: "magnifyingglass"), name: .localized(key: "feature1")),
        (image: UIImage(named: "Record"), name: .localized(key: "feature2")),
        (image: UIImage(named: "Doctor"), name: .localized(key: "feature3"))
    ]
}
