//
//  SettingsTableViewController.swift
//  EsViJi
//
//  Created by Роман Есин on 23.10.2021.
//

import UIKit

enum SettingSection: String, CaseIterable {
    case general
    case additional
}

enum SettingItem: String {
    case defaultBackground = "Default Background"
    case darkModeArtboard = "Dark mode artboard"

    var reuseIdentifier: String {
        switch self {
        case .defaultBackground:
            return "BackgroundColorCell"
        case .darkModeArtboard:
            return "DarkmodeArtboardCell"
        }
    }
}

class SettingsDataSource: UITableViewDiffableDataSource<SettingSection, SettingItem> {
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SettingSection.allCases[section].rawValue
    }
}

class SettingsData {
    var defaultBackground: UIColor? = .red
    var darkModeArtboard: Bool = true
}

protocol SettingsCell: UITableViewCell {
    func configure(with data: SettingsData)
}

class BackgroundColorCell: UITableViewCell, SettingsCell {
    static let identifier = SettingItem.defaultBackground.reuseIdentifier

    lazy var colorView = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    func setupView() {

        contentView.addSubview(colorView)
        colorView.translatesAutoresizingMaskIntoConstraints = false
        colorView.backgroundColor = .tertiarySystemGroupedBackground
        colorView.layer.cornerRadius = 12
        colorView.layer.borderColor = UIColor.tertiarySystemGroupedBackground.cgColor
        colorView.layer.borderWidth = 4

        NSLayoutConstraint.activate([
            colorView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            colorView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            colorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            colorView.widthAnchor.constraint(equalToConstant: 90),
            colorView.heightAnchor.constraint(equalToConstant: 32)
        ])
    }

    func configure(with data: SettingsData) {
        textLabel?.text = SettingItem.defaultBackground.rawValue
        colorView.backgroundColor = data.defaultBackground
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SettingsTableViewController: UITableViewController {
    var settingsData = SettingsData()

    lazy var dataSource = SettingsDataSource(tableView: tableView) { tableView, indexPath, itemIdentifier in
        guard let cell = tableView
                .dequeueReusableCell(withIdentifier: itemIdentifier.reuseIdentifier) as? SettingsCell
        else { return UITableViewCell() }

        cell.configure(with: self.settingsData)

        return cell
    }

    init() {
        super.init(style: .insetGrouped)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(BackgroundColorCell.self, forCellReuseIdentifier: BackgroundColorCell.identifier)

        tableView.dataSource = dataSource

        var snapshot = dataSource.snapshot()
        snapshot.appendSections(SettingSection.allCases)
        snapshot.appendItems([.defaultBackground, .darkModeArtboard], toSection: .general)
        dataSource.apply(snapshot, animatingDifferences: false)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }

        switch item {
        case .defaultBackground:
            let colorPicker = UIColorPickerViewController()
            colorPicker.delegate = self
            colorPicker.modalPresentationStyle = .formSheet
            if let sheet = colorPicker.sheetPresentationController {
                sheet.detents = [.medium(), .large()]
                sheet.selectedDetentIdentifier = .medium
                sheet.largestUndimmedDetentIdentifier = .medium
                sheet.prefersGrabberVisible = true
            }
            present(colorPicker, animated: true)
        default:
            return
        }
    }
}

extension SettingsTableViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        settingsData.defaultBackground = viewController.selectedColor
        tableView.reloadData()
    }

    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        settingsData.defaultBackground = viewController.selectedColor
        tableView.reloadData()
    }
}
