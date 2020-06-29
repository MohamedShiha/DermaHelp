//
//  LoadingView.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 6/29/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

class LoadingView: UIView {

    // MARK: Views
    
    private var activityIndicator = UIActivityIndicatorView(style: .large)
    
    // MARK: Properties
    
    var isLoading: Bool {
        return activityIndicator.isAnimating
    }
    
    // MARK: Initializers
    
    init() {
        super.init(frame: .zero)
        alpha = 0
        backgroundColor = .white
        addSubview(activityIndicator)
        activityIndicator.edgesToSuperView()
        dropShadow()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 12
    }
    
    private func dropShadow() {
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 6
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
    func startLoading() {
        alpha = 1
        activityIndicator.startAnimating()
    }
    
    func stopLoading() {
        alpha = 0
        activityIndicator.stopAnimating()
        removeFromSuperview()
    }
}
