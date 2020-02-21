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
    struct FolderConfig {
        var currentFolder: (Folder) -> Void
    }

    private var folderConfiguration: FolderConfig?

    func configure(with config: FolderConfig) {
        folderConfiguration = config
    }

    private var navigationController: UINavigationController

    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController ?? UINavigationController()
    }

    func start() {
        showFolders()
    }

    private func showFolders() {
        let vc = FoldersViewController.instantiate()
        vc.configure(with: .init(
            newFolderTapped: { [weak self] in
                self?.showAddFolders()
            },
            cellTapped: { [weak self] folder in
                self?.folderConfiguration?.currentFolder(folder)
                self?.openTodos()
            }
        ))
        navigationController.pushViewController(vc, animated: true)
    }

    private func showAddFolders() {
        let vc = AddFoldersViewController.instantiate()
        vc.configure(with: .init(
            closeAddTapped: { [weak self] in
                self?.showFolders()
            }
        ))
        navigationController.pushViewController(vc, animated: true)
    }

    private func openTodos() {
        var coordinator: TodosCoordinator?
        coordinator = TodosCoordinator(navigationController: navigationController)
        coordinator?.start()
    }

}
