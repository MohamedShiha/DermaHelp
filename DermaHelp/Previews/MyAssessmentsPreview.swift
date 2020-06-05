//
//  MyAssessmentsPreview.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/8/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import SwiftUI

struct MyAssessmentsPreview : PreviewProvider, UIViewControllerRepresentable {
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<MyAssessmentsPreview>) -> MyAssessmentsVC {
        return MyAssessmentsVC(viewModel: Assessments(userVM: UserViewModel(user: User())))
    }
    
    func updateUIViewController(_ uiViewController: MyAssessmentsVC, context: UIViewControllerRepresentableContext<MyAssessmentsPreview>) {  }
    
    static var previews : some View {
        
        Group {
            MyAssessmentsPreview().previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro Max"))
            .previewDisplayName("iPhone 11 Pro Max")
            
            MyAssessmentsPreview().previewDevice(PreviewDevice(rawValue: "iPhone SE (2nd generation)"))
            .previewDisplayName("iPhone SE")
        }
    }
}
