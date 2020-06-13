//
//  SaveAccessoryButton.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 6/7/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

class SaveAccessoryButton: Button {
    
    // MARK: Views
    
    private var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Properties
    
    var isLoading: Bool {
        if let activity = activityIndicator {
            return activity.isAnimating
        } else {
            return false
        }
    }
    
    // MARK: Initializers
    
    init() {
        super.init(title: "SAVE", font: .roundedSystemFont(ofSize: 19, weight: .bold), titleColor: .white, backColor: .mainTint)
        isEnabled = false
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 0
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
