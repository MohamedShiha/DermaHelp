//
//  MediaOptionButton.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/10/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

class MediaOptionButton: Button {

    init(image: UIImage?, title: String) {
        super.init(title: title, font: .roundedSystemFont(ofSize: UIFont.buttonFontSize, weight: .bold), titleColor: .label, backColor: .systemFill)
        tintColor = .label
        setImage(image, for: .normal)
        contentHorizontalAlignment = .left
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        adjustsImageWhenHighlighted = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
