//
//  CardAnimationController.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 6/28/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

class CardAnimationController: NSObject {
    
    private let animationDuration: TimeInterval
    private let animationType: AnimationType
    private let assessmentView: AssessmentView
    
    enum AnimationType {
        case present
        case dismiss
    }
    
    init(assessmentView: AssessmentView, duration: TimeInterval, type: AnimationType) {
        animationDuration = duration
        animationType = type
        self.assessmentView = assessmentView
    }
}

// MARK: UIViewControllerAnimatedTransitioning

extension CardAnimationController: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let fromVC = transitionContext.viewController(forKey: .from), let toVC = transitionContext.viewController(forKey: .to) else {
            transitionContext.completeTransition(false)
            return
        }
        
        switch animationType {
        case .present:
            transitionContext.containerView.addSubview(toVC.view)
            presentAnimation(with: transitionContext, viewToAnimate: toVC.view)
        case .dismiss:
            transitionContext.containerView.addSubview(fromVC.view)
            dismissAnimation(with: transitionContext, viewToAnimate: fromVC.view)
        }
    }
    
    func presentAnimation(with context: UIViewControllerContextTransitioning, viewToAnimate view: UIView) {

        // Get the coordinate based on position on the main UIWindow
        let point = assessmentView.convert(assessmentView.frame.origin, to: nil)
        let origin = CGPoint(x: 16, y: point.y)
        view.frame = UIScreen.main.bounds
        
        let screenSize = UIScreen.main.bounds.size
        let xScale = assessmentView.frame.width / screenSize.width
        let yScale = assessmentView.frame.height / screenSize.height
        view.transform = CGAffineTransform.identity.scaledBy(x: xScale, y: yScale)
        view.frame.origin = origin
        view.alpha = 0
        
        let duration = transitionDuration(using: context)
        UIView.animate(withDuration: duration,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.1,
                       options: .curveEaseInOut,
                       animations: {
                view.alpha = 1
                view.transform = .identity
                view.frame.origin = .zero
        }) { _ in
            context.completeTransition(true)
        }
    }
    
    func dismissAnimation(with context: UIViewControllerContextTransitioning, viewToAnimate view: UIView) {
        
        // Get the coordinate based on position on the main UIWindow
        let point = assessmentView.convert(assessmentView.frame.origin, to: nil)
        let origin = CGPoint(x: 16, y: point.y)
        
        let screenSize = UIScreen.main.bounds.size
        let xScale = assessmentView.frame.width / screenSize.width
        let yScale = assessmentView.frame.height / screenSize.height
        
        let duration = transitionDuration(using: context)
        UIView.animate(withDuration: duration,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.1,
                       options: .curveEaseInOut,
                       animations: {
                view.alpha = 0
                view.transform = CGAffineTransform.identity.scaledBy(x: xScale, y: yScale)
                view.frame.origin = origin
        }) { _ in
            context.completeTransition(true)
        }
    }
}
