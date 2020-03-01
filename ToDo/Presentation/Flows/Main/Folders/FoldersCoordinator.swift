//
//  FoldersCoordinator.swift
//  ToDo
//
//  Created by Ilya Matveev on 17.02.2020.
//  Copyright © 2020 Ilya Matveev. All rights reserved.
//

import Foundation
import UIKit

final class FoldersCoordinator: Coordinator {
    struct Config {
        var openAuth: () -> Void
    }

    private var configuration: Config?

    var currentCoordinator: Coordinator?
    var navigationController: UINavigationController

    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController ?? UINavigationController()
    }

    func start() {
        showFolders()
    }

    func configure(with config: Config) {
        configuration = config
    }

    private func showFolders() {
        let vc = FoldersViewController.instantiate()
        vc.configure(with: .init(
            newFolderTapped: { [weak self] in
                self?.showAddFolders()
            },
            cellTapped: { [weak self] folder in
                self?.openTodos(in: folder)
            },
            logOutTapped: { [weak self] in
                self?.configuration?.openAuth()
        }
        ))
        navigationController.pushViewController(vc, animated: true)
    }

    private func showAddFolders() {
        let vc = AddFoldersViewController.instantiate()
        let navController = UINavigationController(rootViewController: vc)
        navigationController.present(navController, animated: true, completion: nil)
    }

    private func openTodos(in folder: Folder) {
        var coordinator: TodosCoordinator?
        coordinator = TodosCoordinator(navigationController: navigationController)
        currentCoordinator = coordinator
        coordinator?.start(in: folder)
    }

}
