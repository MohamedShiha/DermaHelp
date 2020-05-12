//
//  ProfileImageView.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/11/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

class ProfileImageView: UIImageView {
    
    init() {
        super.init(image: UIImage(named: "DemoUser"))
        clipsToBounds = true
        backgroundColor = .systemFill
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }
}
