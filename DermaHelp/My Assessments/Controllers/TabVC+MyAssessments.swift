//
//  TabVC+MyAssessments.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 6/12/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

extension TabController {
    func myAssessmentsTab() {
        let vc = MyAssessmentsVC(viewModel: Assessments(userVM: UserViewModel(user: User())))
        vc.tabBarItem = UITabBarItem(title: "Assessments", image: UIImage(named: "Record_Tab"), selectedImage: UIImage(named: "Record_ActiveTab"))
        let nav = vc.embedInNavigationController()
        viewControllers = [nav]
    }
}
