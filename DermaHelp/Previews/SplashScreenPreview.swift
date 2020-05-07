//
//  SplashScreenPreview.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/6/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import SwiftUI

struct SplashScreenPreview : PreviewProvider, UIViewControllerRepresentable {
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SplashScreenPreview>) -> SplashScreenVC {
        return SplashScreenVC()
    }
    
    func updateUIViewController(_ uiViewController: SplashScreenVC, context: UIViewControllerRepresentableContext<SplashScreenPreview>) {  }
    
    static var previews : some View {
        
        Group {
            SplashScreenPreview().previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro Max"))
            .previewDisplayName("iPhone 11 Pro Max")
            
            SplashScreenPreview().previewDevice(PreviewDevice(rawValue: "iPhone SE (2nd generation)"))
            .previewDisplayName("iPhone SE")
        }
    }
}

