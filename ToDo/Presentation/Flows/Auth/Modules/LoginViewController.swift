//
//  LoginViewController.swift
//  ToDo
//
//  Created by Ilya Matveev on 22.12.2019.
//  Copyright © 2019 Ilya Matveev. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController, Storyboarded {
    struct Config {
        var signInTapped: () -> Void
        var signUpTapped: () -> Void
    }

    @IBOutlet private var signInOutlet: UIButton!
    @IBOutlet private var signUpOutlet: UIButton!

    private var configuration: Config?

    func configure(with config: Config) {
        configuration = config
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        signInOutlet.layer.cornerRadius = 6
        signUpOutlet.layer.cornerRadius = 6
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    @IBAction private func signInTapped(_ sender: UIButton) {
        configuration?.signInTapped()
    }

    @IBAction private func signUpTapped(_ sender: UIButton) {
        configuration?.signUpTapped()
    }
    
}
