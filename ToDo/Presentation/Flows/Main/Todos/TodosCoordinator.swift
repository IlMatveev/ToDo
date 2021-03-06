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
    var currentCoordinator: Coordinator?

    private var navigationController: UINavigationController

    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController ?? UINavigationController()
    }

    func start(in folder: Folder) {
        showTodos(in: folder)
    }

    private func showTodos(in folder: Folder) {
        let vc = TodoListViewController.instantiate()
        vc.configure(with: .init(
            addTapped: { [weak self] in
                self?.showAddOrEdit(in: folder, with: nil)
            },
            cellTapped: { [weak self] todo in
                self?.showDetails(in: folder, about: todo)
            }
        ))
        vc.currentFolder = folder

        navigationController.pushViewController(vc, animated: true)
    }

    private func showAddOrEdit(in folder: Folder, with todo: Todo?) {
        let vc = AddTodoViewController.instantiate()
 
        vc.currentFolder = folder
        vc.currentItem = todo

        let navController = UINavigationController(rootViewController: vc)
        navigationController.present(navController, animated: true, completion: nil)
    }

    private func showDetails(in folder: Folder, about todo: Todo) {
        let vc = TodoDetailsViewController.instantiate()
        vc.configure(with: .init(
            editTapped: { [weak self] in
                self?.showAddOrEdit(in: folder, with: todo)
            }
        ))
        vc.currentItem = todo
        vc.currentFolder = folder

        navigationController.pushViewController(vc, animated: true)
    }

}
