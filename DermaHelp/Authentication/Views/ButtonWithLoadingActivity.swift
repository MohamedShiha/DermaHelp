//
//  ButtonWithLoadingActivity.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 6/13/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

class ButtonWithLoadingActivity: Button {
    
    // MARK: Views
    
    private var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Properties
    
    let radius: CGFloat
    var isLoading: Bool {
        if let activity = activityIndicator {
            return activity.isAnimating
        } else {
            return false
        }
    }
    
    // MARK: Initializers
    
    init(title: String, font: UIFont = .roundedSystemFont(ofSize: UIFont.buttonFontSize, weight: .bold),
         titleColor: UIColor = .white, backColor: UIColor = .mainTint, cornerRadius: CGFloat) {
        radius = cornerRadius
        super.init(title: title, font: .roundedSystemFont(ofSize: 19, weight: .bold), titleColor: .white, backColor: .mainTint)
        isEnabled = false
    }

    required init?(coder: NSCoder) {
        radius = 0
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = radius
    }
    
    func showLoadingIndicator() {
        isEnabled = false
        if activityIndicator == nil {
            activityIndicator = UIActivityIndicatorView(style: .medium)
            activityIndicator.color = .white
            addSubview(activityIndicator)
            activityIndicator.edgesToSuperView(including: [.top, .bottom, .right])
            activityIndicator.aspectRatio(multiplier: 1)
            activityIndicator.startAnimating()
        }
    }
    
    func hideLoadingIndicator() {
        isEnabled = true
        activityIndicator?.stopAnimating()
        activityIndicator?.removeFromSuperview()
        activityIndicator = nil
    }
}
