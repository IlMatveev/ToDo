//
//  AppCoordinator.swift
//  ToDo
//
//  Created by Ilya Matveev on 22.02.2020.
//  Copyright © 2020 Ilya Matveev. All rights reserved.
//

import Foundation
import UIKit

import Foundation
import UIKit

final class AppCoordinator: Coordinator {
    private var navigationController: UINavigationController

    var childCoordinators: [Coordinator] = []

    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController ?? UINavigationController()
    }

    func start() {
    }

}
