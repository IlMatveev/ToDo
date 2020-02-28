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
    var window: UIWindow

    var currentCoordinator: Coordinator?

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let currentUser = UserService.shared.currentUser
        if currentUser != nil {
            openFolders()
        } else {
            openAuth()
        }
    }

    private func openAuth() {
        let authCoord = AuthCoordinator()
        let navController = authCoord.navigationController
        
        window.rootViewController = navController

        currentCoordinator = authCoord

        authCoord.configure(with: .init(
            openFolders: {
                self.openFolders()
            }
        ))
        authCoord.start()
    }

    private func openFolders() {
        let foldCoord = FoldersCoordinator()
        let navController = foldCoord.navigationController

        window.rootViewController = navController

        currentCoordinator = foldCoord

        foldCoord.configure(with: .init(
            openAuth: {
                self.openFolders()
            }
        ))
        foldCoord.start()
    }

}
