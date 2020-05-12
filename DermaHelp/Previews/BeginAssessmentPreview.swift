//
//  BeginAssessmentPreview.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/10/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import SwiftUI

struct BeginAssessmentPreview : PreviewProvider, UIViewControllerRepresentable {
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<BeginAssessmentPreview>) -> BeginAssessmentVC {
        return BeginAssessmentVC()
    }
    
    func updateUIViewController(_ uiViewController: BeginAssessmentVC, context: UIViewControllerRepresentableContext<BeginAssessmentPreview>) {  }
    
    static var previews : some View {
        
        Group {
            BeginAssessmentPreview().previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro Max"))
            .previewDisplayName("iPhone 11 Pro Max")
            
            BeginAssessmentPreview().previewDevice(PreviewDevice(rawValue: "iPhone SE (2nd generation)"))
            .previewDisplayName("iPhone SE")
        }
    }
}
