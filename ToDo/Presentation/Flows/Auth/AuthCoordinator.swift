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
    private var navigationController: UINavigationController

    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController ?? UINavigationController()
    }

    func start() {
        showLogin()
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
        navigationController.pushViewController(vc, animated: false)
    }

    private func showSignIn() {
        let vc = SignInViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }

    private func showSignUp() {
        let vc = SignUpViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }

    private func openFolders() {

    }

}
