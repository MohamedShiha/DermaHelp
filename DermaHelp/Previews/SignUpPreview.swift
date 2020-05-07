//
//  SignUpPreview.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/7/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import SwiftUI

struct SignUpPreview : PreviewProvider, UIViewControllerRepresentable {
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SignUpPreview>) -> SignUpFormVC {
        return SignUpFormVC()
    }
    
    func updateUIViewController(_ uiViewController: SignUpFormVC, context: UIViewControllerRepresentableContext<SignUpPreview>) {  }
    
    static var previews : some View {
        
        Group {
            SignUpPreview().previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro Max"))
            .previewDisplayName("iPhone 11 Pro Max")
            
            SignUpPreview().previewDevice(PreviewDevice(rawValue: "iPhone SE (2nd generation)"))
            .previewDisplayName("iPhone SE")
        }
    }
}
