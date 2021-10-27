//
//  LayersTableViewController.swift
//  EsViJi
//
//  Created by Роман Есин on 25.10.2021.
//

import UIKit

class LayersDataSource: UITableViewDiffableDataSource<Int, Layer> {}

class LayersTableViewController: UITableViewController {

    var layers: [Layer] = [
        .init(title: "Test layer 1"),
        .init(title: "Test layer 2"),
        .init(title: "Test group 1", subitems: [.init(title: "Test layer 3")]),
        .init(title: "Test group 2", subitems: [.init(title: "Test layer 4")])
    ]

    init() {
        super.init(nibName: nil, bundle: nil)
        title = "Layers"

        let createGroupButton = UIBarButtonItem(image: .init(systemName: "plus"), style: .plain, target: self, action: #selector(createGroup))
        let actionsButton = UIBarButtonItem(image: .init(systemName: "ellipsis"), style: .plain, target: nil, action: nil)

        let rulersAction = UIAction { _ in

        }
        rulersAction.title = "Show rulers"
        rulersAction.image = .init(systemName: "ruler")

        let gridAction = UIAction { _ in

        }
        gridAction.title = "Show grid"
        gridAction.image = .init(systemName: "grid")

        actionsButton.menu = .init(title: "Hello", image: nil, identifier: nil, options: .displayInline, children: [rulersAction, gridAction])
        let closeButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(close))

        navigationItem.setLeftBarButton(createGroupButton, animated: false)
        navigationItem.setRightBarButtonItems([closeButton, actionsButton], animated: false)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var dataSource = LayersDataSource(tableView: tableView) { tableView, indexPath, itemIdentifier in
        guard let cell = tableView
                .dequeueReusableCell(withIdentifier: LayerCell.identifier) as? LayerCell
        else { return UITableViewCell() }

        cell.config(itemIdentifier)

        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        tableView.dataSource = dataSource

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        tableView.register(LayerCell.self, forCellReuseIdentifier: LayerCell.identifier)

        tableView.dataSource = dataSource

        var snapshot = dataSource.snapshot()
        snapshot.appendSections([1])
        snapshot.appendItems(layers, toSection: 1)
        dataSource.apply(snapshot, animatingDifferences: false)
    }

    @objc func createGroup() {

    }

    @objc func actionsButtonTapped() {

    }

    @objc func close() {
        dismiss(animated: true)
    }
}
