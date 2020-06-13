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
    
    private let collectionView = FeaturesCollectionView()
    private let pageControl = PageControl(numberOfPages: Features.list.count)

    // MARK: Initializers
    
    init() {
        super.init(frame: .zero)
        setupViews()
        setupLayout()
        collectionView.scrollingDelegate = self
        clipsToBounds = true
        layer.cornerRadius = 16
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
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
