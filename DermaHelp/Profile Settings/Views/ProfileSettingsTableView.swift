//
//  ProfileSettingsTableView.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 6/7/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

protocol TableViewPresentingVCDelegate: class {
    func presentAlert(title: String, message: String?, dismissingTitle: String)
    func presentAlertWithHandler(title: String, message: String?,
                                 buttonsStackAxis axis: NSLayoutConstraint.Axis, actionTitle: String,
                                 actionType type: AlertController.Action,
                                 alertStyle style: UIAlertAction.Style, _ handler: (() -> Void)?)
    func navigate(to vc: UIViewController)
    func clearAssessments()
    func logOut()
}

class ProfileSettingsTableView: UITableView {
    
    // MARK: Properties
    
    var viewModel: UserViewModel
    private var options: [[SettingsListItem]]!
    weak var parentDelegate: TableViewPresentingVCDelegate?
    
    // MARK: Initializers
    
    init(viewModel: UserViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero, style: .plain)
        showsVerticalScrollIndicator = false
        register(ProfileSettingsCell.self, forCellReuseIdentifier: ProfileSettingsCell.cellId)
        setupContent()
        delegate = self
        dataSource = self
        separatorColor = UIColor(displayP3Red: 60/255, green: 60/255, blue: 67/255, alpha: 0.1)
        isScrollEnabled = false
    }
    
    required init?(coder: NSCoder) {
        viewModel = UserViewModel(user: User())
        super.init(coder: coder)
    }
    
    // MARK: Setup UI and Content
    
    private func setupContent() {
        options = [
            [
                SettingsListItem(name: .localized(key: "name"), data: viewModel.name, handler: {
                    self.navigate(to: NameEditingVC(viewModel: self.viewModel))
                }),
                SettingsListItem(name: .localized(key: "gender"), data: viewModel.gender?.rawValue, handler: {
                    self.navigate(to: GenderEditingVC(viewModel: self.viewModel))
                }),
                SettingsListItem(name: .localized(key: "birthday"), data: viewModel.birthDate?.formattedWithMonthName, handler: {
                    self.navigate(to: BirthDayEditingVC(viewModel: self.viewModel))
                }),
                SettingsListItem(name: .localized(key: "email address"), data: viewModel.email, handler: {
                    self.navigate(to: EmailEditingVC(viewModel: self.viewModel))
                }),
                SettingsListItem(name: .localized(key: "password"), data: nil, handler: {
                    self.navigate(to: ReauthenticationVC(viewModel: self.viewModel))
                })
            ],
            [
                SettingsListItem(name: .localized(key: "clear assessments"), data: viewModel.assessmentIds.count.localized(), handler: {
                    if !self.viewModel.assessmentIds.isEmpty {
                        self.verifyClearingAssessments()
                    } else {
                        self.parentDelegate?.presentAlert(title: .localized(key: "empty assessment alert"), message: nil, dismissingTitle: "Okay")
                    }
                }),
                SettingsListItem(name: .localized(key: "log out"), data: nil, handler: {
                    self.verifyLogOut()
                })
            ]
        ]
    }
    
    private func updateUserData() {
        options[0][0].data = viewModel.name
        options[0][1].data = .localized(key: viewModel.gender?.rawValue ?? "")
        options[0][2].data = viewModel.birthDate?.formattedWithMonthName
        options[0][3].data = viewModel.email
        options[1][0].data = viewModel.assessmentIds.count.localized()
    }
    
    private func navigate(to vc: UIViewController) {
        parentDelegate?.navigate(to: vc)
    }
    
    private func verifyClearingAssessments() {
        let title = String.localized(key: "verify clearing assessments")
        let message = String.localized(key: "verify clearing message")
        let action = String.localized(key: "clear assessments")
        parentDelegate?.presentAlertWithHandler(title: title, message: message,
                                                buttonsStackAxis: .vertical, actionTitle: action,
                                                actionType: .primary, alertStyle: .cancel, {
            self.parentDelegate?.clearAssessments()
        })
    }
    
    private func verifyLogOut() {
        let title = String.localized(key: "verify log out")
        let actionTitle = String.localized(key: "log out")
        parentDelegate?.presentAlertWithHandler(title: title, message: nil,
                                                buttonsStackAxis: .horizontal, actionTitle: actionTitle,
                                                actionType: .primary, alertStyle: .cancel, {
            self.parentDelegate?.logOut()
        })
    }
    
    override func reloadData() {
        updateUserData()
        super.reloadData()
    }
}

// MARK: DataSource Delegate

extension ProfileSettingsTableView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileSettingsCell.cellId, for: indexPath) as! ProfileSettingsCell
        cell.option = options[indexPath.section][indexPath.row]
        return cell
    }
}

// MARK: Tableview Delegate

extension ProfileSettingsTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        var sectionTitle = ""
        if section == 0 { sectionTitle = .localized(key: "my account") }
        else if section == 1 { sectionTitle = .localized(key: "account actions") }
        let label = Label(text: sectionTitle,
                          font: .roundedSystemFont(ofSize: 13, weight: .semibold), color: .mainTint,
                          padding: UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0))
        label.backgroundColor = .secondarySystemBackground
        headerView.addSubview(label)
        label.edgesToSuperView()
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        options[indexPath.section][indexPath.row].handler()
    }
}
