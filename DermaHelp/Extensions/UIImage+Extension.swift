//
//  UIImage+Extension.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/11/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

extension UIImage {
    
    func roundedImageWithBorder(width: CGFloat, color: UIColor = .clear) -> UIImage? {
        let square = CGSize(width: min(size.width, size.height) + width * 2, height: min(size.width, size.height) + width * 2)
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: square))
        imageView.contentMode = .center
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
    
    func encodeToBase64(compressionQuality: CGFloat = 0.7) -> String {
        let imgData = self.jpegData(compressionQuality: compressionQuality)
        return (imgData?.base64EncodedString(options: .lineLength64Characters)) ?? String()
    }
}
