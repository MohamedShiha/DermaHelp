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
        profileTab()
    }
    
    private func myAssessmentsTab() {
        let vc = MyAssessmentsVC()
        vc.tabBarItem = UITabBarItem(title: "Assessments", image: UIImage(named: "Record_Tab"), selectedImage: UIImage(named: "Record_ActiveTab"))
        viewControllers = [vc]
    }
    
    private func profileTab() {
        let vc = ProfileVC()
        let image = UIImage(named: "DemoUser")
        vc.tabBarItem = UITabBarItem(title: "Me", image: image?.roundedImageWithBorder(width: 0), selectedImage: image?.roundedImageWithBorder(width: 1, color: .mainTint))
        viewControllers?.append(vc)
    }
}
