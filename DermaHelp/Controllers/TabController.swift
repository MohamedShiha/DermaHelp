//
//  TabController.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/8/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

class TabController: UITabBarController {

    // MARK: View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .mainTint
        setupTabs()
    }
    
    // MARK: Tabs
    
    private func setupTabs() {
        viewControllers = [UIViewController]()
        myAssessmentsTab()
    }
    
    private func myAssessmentsTab() {
        let vc = MyAssessmentsVC()
        vc.tabBarItem = UITabBarItem(title: "My Assessments", image: UIImage(named: "Record_Tab"), selectedImage: UIImage(named: "Record_ActiveTab"))
        viewControllers = [vc]
    }
}
