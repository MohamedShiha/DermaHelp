//
//  PageControl.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 5/6/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

class PageControl: UIPageControl {

    init(numberOfPages: Int, currentPageTint: UIColor? = .label, indicatorTint: UIColor? = .lightGray) {
        super.init(frame: .zero)
        self.numberOfPages = numberOfPages
        currentPageIndicatorTintColor = currentPageTint
        pageIndicatorTintColor = indicatorTint
        isEnabled = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
