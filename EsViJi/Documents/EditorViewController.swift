//
//  EditorViewController.swift
//  EsViJi
//
//  Created by Роман Есин on 25.10.2021.
//

import UIKit

class EditorViewController: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
        title = "Document title"

        navigationItem.largeTitleDisplayMode = .never
        navigationItem.backButtonDisplayMode = .minimal

        let layerButton = UIBarButtonItem(image: .init(systemName: "list.bullet.indent"), style: .plain, target: self, action: #selector(showLayers))
        let pencilButton = UIBarButtonItem(image: .init(systemName: "pencil.tip"), style: .plain, target: nil, action: nil)

        let squareAction = UIAction { _ in

        }
        squareAction.title = "Square"
        squareAction.image = .init(systemName: "square")

        let circleAction = UIAction { _ in

        }
        circleAction.title = "Circle"
        circleAction.image = .init(systemName: "circle")

        let pencilAction = UIAction { _ in

        }
        pencilAction.title = "Pencil"
        pencilAction.image = .init(systemName: "pencil")

        pencilButton.menu = .init(title: "Pencil", image: nil, identifier: nil, options: .displayInline, children: [squareAction, circleAction, pencilAction])

        navigationItem.setRightBarButtonItems([pencilButton, layerButton], animated: false)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    @objc func showLayers() {
        if let presentedController = presentedViewController {
            presentedController.dismiss(animated: true)
            return
        }

        let vc = LayersTableViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .formSheet
        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.selectedDetentIdentifier = .medium
            sheet.largestUndimmedDetentIdentifier = .medium
            sheet.prefersGrabberVisible = true
        }
        present(nav, animated: true)
    }
}
