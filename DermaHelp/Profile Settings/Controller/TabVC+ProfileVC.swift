//
//  TabVC+ProfileVC.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 6/12/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

extension TabController {
    func profileTab() {
        let vc = ProfileVC(viewModel: UserViewModel(user: User()))
        let image = UIImage.profilePlaceholder
        vc.tabBarItem = UITabBarItem(title: "Me", image: image?.roundedImageWithBorder(width: 0),
                                     selectedImage: image?.roundedImageWithBorder(width: 2, color: .mainTint))
        let nav = vc.embedInNavigationController()
        var vcArray = viewControllers
        vcArray?.append(nav)
        setViewControllers(vcArray, animated: true)
    }
}
