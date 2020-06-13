//
//  UIImage+Extension.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/11/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

extension UIImage {
    
    static var profilePlaceholder: UIImage? {
        return UIImage(named: "UserPlaceholder")
    }
    
    func roundedImageWithBorder(width: CGFloat, color: UIColor = .clear) -> UIImage? {
        let square = CGSize(width: 28, height: 28)
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: square))
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .systemFill
        imageView.image = self
        imageView.layer.cornerRadius = square.width/2
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = width
        imageView.layer.borderColor = color.cgColor
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        var result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        result = result?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        return result
    }
}
