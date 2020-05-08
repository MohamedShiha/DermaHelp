//
//  GoogleButton.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/6/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

class GoogleButton: FormButton {

    init() {
        super.init(title: "Continue with Google", titleColor: .black(0.1, alpha: 0.6), backColor: .systemFill)
        setImage(UIImage(named: "Google"), for: .normal)
        imageEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 32)
        adjustsImageWhenHighlighted = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
