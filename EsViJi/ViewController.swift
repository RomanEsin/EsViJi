//
//  ViewController.swift
//  EsViJi
//
//  Created by Роман Есин on 23.10.2021.
//

import UIKit

struct TabViewController {
    let controller: UIViewController

    init(title: String, imageName: String, controller: UIViewController) {
        controller.title = title
        controller.tabBarItem = .init(title: title,
                                      image: .init(systemName: imageName),
                                      selectedImage: .init(systemName: "\(imageName).fill"))

        if let controller = controller as? UINavigationController {
            controller.viewControllers.first?.title = title
        }

        self.controller = controller
    }
}

class NavigationController: UINavigationController {
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        self.navigationBar.prefersLargeTitles = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ViewController: UITabBarController {

    lazy var tabControllers = [
        TabViewController(title: "Documents",
                          imageName: "doc.text",
                          controller: NavigationController(rootViewController: UIViewController())),
        TabViewController(title: "Settings",
                          imageName: "gearshape",
                          controller: NavigationController(rootViewController: SettingsTableViewController()))
    ]

    init() {
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = tabControllers.map { $0.controller }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
