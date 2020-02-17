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
    private var navigationController: UINavigationController

    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController ?? UINavigationController()
    }

    func start() {
        showFolders()
    }

    private func showFolders() {
        let vc = FoldersViewController.instantiate()
        
        navigationController.pushViewController(vc, animated: false)
    }

    

}
