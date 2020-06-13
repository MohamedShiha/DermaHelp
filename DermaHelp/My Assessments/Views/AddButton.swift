//
//  AddButton.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/8/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

class AddButton: Button {

    init() {
        super.init(image: UIImage(systemName: "plus"), configuration: .init(pointSize: 18, weight: .bold, scale: .medium))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }
    
    func animateRotation() {
        UIView.animate(withDuration: 0.2) {
            self.transform = CGAffineTransform.identity.rotated(by: .pi / 4)
        }
    }
}
