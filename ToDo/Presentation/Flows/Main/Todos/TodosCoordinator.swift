//
//  TodosCoordinator.swift
//  ToDo
//
//  Created by Ilya Matveev on 17.02.2020.
//  Copyright © 2020 Ilya Matveev. All rights reserved.
//

import Foundation
import UIKit

final class TodosCoordinator: Coordinator {
    private var navigationController: UINavigationController

    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController ?? UINavigationController()
    }

    var currentFolder: Folder?

    func start() {
        showTodos()
    }

    private func showTodos() {
//        FoldersCoordinator.configure(with: .init(
//            currentFolder: { [weak self] folder in
//                self?.currentFolder = folder
//            }
//        ))
        let vc = TodoListViewController.instantiate()
        vc.configure(with: .init(
            addTapped: { [weak self] in
                self?.showAddTodo()
            },
            cellTapped: { [weak self] in
                self?.showTodoDetails()
            }
        ))
        navigationController.pushViewController(vc, animated: true)
    }

    private func showAddTodo() {
        let vc = AddTodoViewController.instantiate()
        vc.configure(with: .init(
            closeAddTapped: { [weak self] in
                self?.showTodos()
            }
        ))
        navigationController.pushViewController(vc, animated: true)
    }

    private func showTodoDetails() {
        let vc = TodoDetailsViewController.instantiate()
        vc.configure(with: .init(
            editTapped: { [weak self] in
                self?.showTodos()
            }
        ))
        navigationController.pushViewController(vc, animated: true)
    }

}
