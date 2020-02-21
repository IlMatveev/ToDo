//
//  MainCoordinator.swift
//  ToDo
//
//  Created by Ilya Matveev on 21.02.2020.
//  Copyright © 2020 Ilya Matveev. All rights reserved.
//

import Foundation
import UIKit

final class MainCoordinator: Coordinator {
    private var navigationController: UINavigationController

    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController ?? UINavigationController()
    }

    func start() {
    }

}
