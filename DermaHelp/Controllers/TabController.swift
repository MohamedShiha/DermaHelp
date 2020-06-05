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
        setupTabs()
        tabBar.tintColor = .mainTint
        view.backgroundColor = .white
        delegate = self
    }
    
    // MARK: Tabs
    
    private func setupTabs() {
        viewControllers = [UIViewController]()
        myAssessmentsTab()
        profileTab()
    }
    
    private func myAssessmentsTab() {
        let vc = MyAssessmentsVC(viewModel: Assessments(userVM: UserViewModel(user: User())))
        vc.tabBarItem = UITabBarItem(title: "Assessments", image: UIImage(named: "Record_Tab"), selectedImage: UIImage(named: "Record_ActiveTab"))
        viewControllers = [vc]
    }
    
    private func profileTab() {
        let vc = ProfileVC(viewModel: UserViewModel(user: User()))
        let image = UIImage.profilePlaceholder
        vc.tabBarItem = UITabBarItem(title: "Me", image: image?.roundedImageWithBorder(width: 0), selectedImage: image?.roundedImageWithBorder(width: 2, color: .mainTint))
        var vcArray = viewControllers
        vcArray?.append(vc)
        setViewControllers(vcArray, animated: true)
    }
}

// MARK: TabBarController Delegate

extension TabController: UITabBarControllerDelegate  {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let tabViewControllers = tabBarController.viewControllers, let toIndex = tabViewControllers.firstIndex(of: viewController) else {
            return false
        }
        animateToTab(toIndex: toIndex)
        return true
    }
    
    func animateToTab(toIndex: Int) {
        guard let tabViewControllers = viewControllers,
            let selectedVC = selectedViewController else { return }
        
        guard let fromView = selectedVC.view,
            let toView = tabViewControllers[toIndex].view,
            let fromIndex = tabViewControllers.firstIndex(of: selectedVC),
            fromIndex != toIndex else { return }
        
        // Add the toView to the tab bar view
        fromView.superview?.addSubview(toView)
        
        // Position toView off screen (to the left/right of fromView)
        let screenWidth = UIScreen.main.bounds.size.width
        let scrollRight = toIndex > fromIndex
        let offset = (scrollRight ? screenWidth : -screenWidth)
        toView.center = CGPoint(x: fromView.center.x + offset, y: toView.center.y)
        
        // Disable interaction during animation
        view.isUserInteractionEnabled = false
        
        UIView.animate(withDuration: 0.3,
                       delay: 0.0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 0,
                       options: .curveEaseOut,
                       animations: {
                        // Slide the views by -offset
                        fromView.center = CGPoint(x: fromView.center.x - offset, y: fromView.center.y)
                        toView.center = CGPoint(x: toView.center.x - offset, y: toView.center.y)
                        
        }, completion: { finished in
            // Remove the old view from the tabBar view.
            fromView.removeFromSuperview()
            self.selectedIndex = toIndex
            self.view.isUserInteractionEnabled = true
        })
    }
}
