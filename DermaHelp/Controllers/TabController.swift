//
//  TabController.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/8/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

class TabController: UITabBarController {
    
    var user: User! {
        didSet {
            profileTab()
        }
    }
    
    // MARK: View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        tabBar.tintColor = .mainTint
        delegate = self
        UserViewModel.fetchCurrentUser { [weak self] (user) in
            self?.user = user
        }
    }
    
    // MARK: Tabs
    
    private func setupTabs() {
        viewControllers = [UIViewController]()
        myAssessmentsTab()
    }
    
    private func myAssessmentsTab() {
        let vc = MyAssessmentsVC()
        vc.tabBarItem = UITabBarItem(title: "Assessments", image: UIImage(named: "Record_Tab"), selectedImage: UIImage(named: "Record_ActiveTab"))
        viewControllers = [vc]
    }
    
    private func profileTab() {
        guard let user = user else { return }
        let vc = ProfileVC(viewModel: UserViewModel(user: user))
        let image = vc.viewModel.picture ?? UIImage(named: "UserPlaceholder")
        vc.tabBarItem = UITabBarItem(title: "Me", image: image?.roundedImageWithBorder(width: 0), selectedImage: image?.roundedImageWithBorder(width: 1, color: .mainTint))
        self.viewControllers?.append(vc)
    }
}

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
