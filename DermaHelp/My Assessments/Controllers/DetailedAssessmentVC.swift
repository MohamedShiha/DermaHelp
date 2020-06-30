//
//  DetailedAssessmentVC.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 6/28/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit
import EZConstraints

class DetailedAssessmentVC: ViewController, LayoutController {

    // MARK: Views
    
    private let closeButton = PlusButton()
    private let imageView = UIImageView()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let dateLabel = Label(text: "Date", font: .roundedSystemFont(ofSize: 16), color: .secondaryBlackLabel)
    private let classNameLabel = Label(text: "Class", font: .roundedSystemFont(ofSize: 22, weight: .bold))
    private let severityLabel = Label(text: .localized(key: "severity"), font: .roundedSystemFont(ofSize: 19, weight: .semibold), color: .secondaryBlackLabel)
    private let statusView = StatusView()
    private let riskRateView = StatusScaleView(metricsLabel: .localized(key: "risk"))
    private let infoHeadingLabel = Label(text: .localized(key: "info heading"), font: .roundedSystemFont(ofSize: 19, weight: .semibold))
    private let informationLabel = Label(font: .roundedSystemFont(ofSize: 16), numberOfLines: 0)
    
    // MARK: Properties
    
    let viewModel: AssessmentViewModel
    
    // MARK: Initializers
    
    init(viewModel: AssessmentViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        imageView.image = viewModel.image
        dateLabel.text = viewModel.date.formatted
        classNameLabel.text = .localized(key: viewModel.className.rawValue + " heading")
        statusView.severity = viewModel.severity
        riskRateView.rate = viewModel.riskRate
        informationLabel.text = cancerClassDictionary[viewModel.className]?.awarenessText
    }
    
    required init?(coder: NSCoder) {
        viewModel = AssessmentViewModel(assessment: Assessment())
        super.init(coder: coder)
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
        closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        modalPresentationStyle = .fullScreen
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        imageView.layTopToSafeArea(constant: 8)
        scrollView.layBottomToSafeArea(constant: 32)
    }
    
    // MARK: Setup UI
    
    func setupViews() {
        
        // Appearance
        imageView.layer.cornerRadius = 16
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        closeButton.transform = CGAffineTransform.identity.rotated(by: .pi / 4)
        closeButton.backgroundColor = .secondarySystemBackground
        
        // Adding subviews
        view.addSubViews([imageView, closeButton, scrollView])
        scrollView.addSubview(contentView)
        contentView.addSubViews([dateLabel, classNameLabel, severityLabel,
        statusView, riskRateView, infoHeadingLabel, informationLabel])
    }
    
    func setupLayout() {
        
        imageView.layLeftInSuperView(constant: 16)
        imageView.widthAnchor(with: view, constant: -32)
        imageView.aspectRatio(multiplier: 1)
        
        closeButton.sizeAnchor(CGSize(width: 30, height: 30))
        closeButton.alignTop(with: imageView, constant: 12)
        closeButton.alignRight(with: imageView, constant: 12)
        
        scrollView.layBelow(imageView, constant: 16)
        scrollView.alignLeft(with: imageView, constant: 0)
        scrollView.alignRight(with: imageView, constant: 0)
        
        contentView.edgesToSuperView()
        contentView.widthAnchor(with: scrollView)
        contentView.heightAnchor(with: scrollView, priority: .defaultLow)
        
        dateLabel.layTopInSuperView(constant: 0)
        dateLabel.layLeftInSuperView(constant: 8)
        
        [classNameLabel, severityLabel, riskRateView, infoHeadingLabel].alignLeft(with: dateLabel, constant: 0)

        classNameLabel.layBelow(dateLabel, constant: 16)

        severityLabel.layBelow(classNameLabel, constant: 12)
        statusView.layRight(to: severityLabel, constant: 8)
        statusView.alignCenterVertically(with: severityLabel, constant: 0)

        riskRateView.layBelow(severityLabel, constant: 12)
        riskRateView.widthAnchor(with: view, multiplier: 0.75)
        infoHeadingLabel.layBelow(riskRateView, constant: 16)
        
        informationLabel.layBelow(infoHeadingLabel, constant: 8)
        informationLabel.edgesToSuperView(including: [.left, .right], insets: .left(8) + .right(8))
        informationLabel.layBottomInSuperView(constant: 0)
    }
    
    // MARK: Actions
    
    @objc
    private func didTapCloseButton() {
        dismiss(animated: true, completion: nil)
    }
}
