//
//  ProfilePreview.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/11/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import SwiftUI

struct ProfilePreview : PreviewProvider, UIViewControllerRepresentable {
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ProfilePreview>) -> ProfileVC {
        return ProfileVC(viewModel: UserViewModel(user: User()))
    }
    
    func updateUIViewController(_ uiViewController: ProfileVC, context: UIViewControllerRepresentableContext<ProfilePreview>) {  }
    
    static var previews : some View {
        
        Group {
            ProfilePreview().previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro Max"))
            .previewDisplayName("iPhone 11 Pro Max")
            
            ProfilePreview().previewDevice(PreviewDevice(rawValue: "iPhone SE (2nd generation)"))
            .previewDisplayName("iPhone SE")
        }
    }
}

