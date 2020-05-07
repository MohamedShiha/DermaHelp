//
//  LoginFormPreview.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/7/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import SwiftUI

struct LoginFormPreview : PreviewProvider, UIViewControllerRepresentable {
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<LoginFormPreview>) -> LoginFormVC {
        return LoginFormVC()
    }
    
    func updateUIViewController(_ uiViewController: LoginFormVC, context: UIViewControllerRepresentableContext<LoginFormPreview>) {  }
    
    static var previews : some View {
        
        Group {
            LoginFormPreview().previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro Max"))
            .previewDisplayName("iPhone 11 Pro Max")
            
            LoginFormPreview().previewDevice(PreviewDevice(rawValue: "iPhone SE (2nd generation)"))
            .previewDisplayName("iPhone SE")
        }
    }
}
