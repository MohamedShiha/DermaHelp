//
//  FormButton.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/6/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

class FormButton: Button {

    init(title: String, titleColor: UIColor?, backColor: UIColor) {
        super.init(title: title, font: .roundedSystemFont(ofSize: UIFont.buttonFontSize, weight: .bold), titleColor: titleColor, backColor: backColor)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
