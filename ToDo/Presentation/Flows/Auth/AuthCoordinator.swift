//
//  AuthCoordinator.swift
//  ToDo
//
//  Created by Ilya Matveev on 14.02.2020.
//  Copyright © 2020 Ilya Matveev. All rights reserved.
//

import Foundation
import UIKit

final class AuthCoordinator: Coordinator {
    struct Config {
        var openFolders: () -> Void
    }

    private var configuration: Config?

    var navigationController: UINavigationController
    var currentCoordinator: Coordinator?

    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController ?? UINavigationController()
    }

    func start() {
        showLogin()
    }

    func configure(with config: Config) {
        configuration = config
    }

    private func showLogin() {
        let vc = LoginViewController.instantiate()
        vc.configure(with: .init(
            signInTapped: { [weak self] in
                self?.showSignIn()
            },
            signUpTapped: { [weak self] in
                self?.showSignUp()
            }
        ))
        navigationController.pushViewController(vc, animated: true)
    }

    private func showSignIn() {
        let vc = SignInViewController.instantiate()
        vc.configure(with: .init(
            signInTapped: { [weak self] in
                self?.configuration?.openFolders()
            }
        ))
        navigationController.pushViewController(vc, animated: true)
    }

    private func showSignUp() {
        let vc = SignUpViewController.instantiate()
        vc.configure(with: .init(
            signUpTapped: { [weak self] in
                self?.showLogin()
            }
        ))
        navigationController.pushViewController(vc, animated: true)
    }

}
