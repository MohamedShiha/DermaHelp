//
//  ProfileSettingsCell.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 6/7/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

class ProfileSettingsCell: UITableViewCell, LayoutController {

    // MARK: Views
    
    let optionLabel = Label(text: "Label", font: .roundedSystemFont(ofSize: 17))
    let dataLabel = Label(text: "Data", font: .roundedSystemFont(ofSize: 16, weight: .medium), color: .secondaryBlackLabel, alignment: .right)
    
    // MARK: Properties
    
    static let cellId = "option"
    var option: SettingsListItem! {
        didSet {
            optionLabel.text = option?.name
            if option?.data == nil {
                dataLabel.isHidden = true
            } else {
                dataLabel.text = option?.data
                dataLabel.isHidden = false
            }
        }
    }
    
    // MARK: Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: Setup UI
    
    func setupViews() {
        contentView.addSubViews([optionLabel, dataLabel])
    }
    
    func setupLayout() {
        optionLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        [optionLabel, dataLabel].centerVertically()
        optionLabel.layLeftInSuperView(constant: 16)
        dataLabel.layRight(to: optionLabel, constant: 16)
        dataLabel.layRightInSuperView(constant: 2)
    }
}
