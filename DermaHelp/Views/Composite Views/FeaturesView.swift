//
//  FeaturesView.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/8/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

class FeaturesView: UIView, LayoutController {

    // MARK: Views
    
    private lazy var collectionView = FeaturesCollectionView()
    private lazy var pageControl = PageControl(numberOfPages: Features.list.count)

    // MARK: Initializers
    
    init() {
        super.init(frame: .zero)
        setupViews()
        setupLayout()
        collectionView.scrollingDelegate = self
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 16
    }
    
    // MARK: Setup UI
    
    func setupViews() {
        addSubViews([collectionView, pageControl])
    }
    
    func setupLayout() {
        collectionView.edgesToSuperView()
        pageControl.centerHorizontally()
        pageControl.heightAnchor(.equal, constant: 24)
        pageControl.layBottomInSuperView(constant: 4)
    }
}

// MARK: CollectionView Scrolling Delegate

extension FeaturesView: ScrollingDelegate {
    func didScroll() {
        pageControl.currentPage = collectionView.indexPathsForVisibleItems.first?.row ?? 0
    }
}
