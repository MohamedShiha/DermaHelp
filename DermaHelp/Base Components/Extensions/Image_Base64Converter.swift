//
//  Image_Base64Converter.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 6/12/20.
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
}

extension UIImage {
    func encodeToBase64(compressionQuality: CGFloat = 0.7) -> String {
        let imgData = self.jpegData(compressionQuality: compressionQuality)
        return (imgData?.base64EncodedString(options: .lineLength64Characters)) ?? String()
    }
}
