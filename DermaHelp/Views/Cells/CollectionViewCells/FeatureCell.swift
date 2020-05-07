//
//  FeatureCell.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/6/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

class FeatureCell: UICollectionViewCell, LayoutController {
    
    private lazy var featureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .black
        return imageView
    }()
    private lazy var featureLabel = Label(font: .roundedSystemFont(ofSize: 22, weight: .semibold))
    
    var feature: (image: UIImage?, name: String)! {
        didSet {
            featureLabel.text = feature.name
            featureImageView.image = feature.image
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupViews() {
        contentView.addSubViews([featureImageView, featureLabel])
    }
    
    func setupLayout() {
        
        [featureImageView, featureLabel].centerVertically(yOffset: -2)
        
        featureImageView.layLeftInSuperView(constant: 24)
        featureImageView.aspectRatio(multiplier: 1)
        featureImageView.aspectRatio(by: contentView, multiplier: 0.4)
        
        featureLabel.layRight(to: featureImageView, constant: 12)
    }
}
