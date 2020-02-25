//
//  AppCoordinator.swift
//  ToDo
//
//  Created by Ilya Matveev on 22.02.2020.
//  Copyright © 2020 Ilya Matveev. All rights reserved.
//

import Foundation
import UIKit

final class AppCoordinator: Coordinator {
    private var navigationController: UINavigationController

    var childCoordinators: [Coordinator] = []

    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController ?? UINavigationController()
    }

    func addCoordinator(coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }

    func removeCoordinator(coordinator: Coordinator) {
        guard let index = childCoordinators.firstIndex(where: {$0 === coordinator}) else {
            fatalError("Coordinator not found")
        }
        childCoordinators.remove(at: index)
    }

    func start() {
    }

    private func openAuth() {
        
    }

    private func main() {

    }

}
