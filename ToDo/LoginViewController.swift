//
//  LoginViewController.swift
//  ToDo
//
//  Created by Ilya Matveev on 22.12.2019.
//  Copyright © 2019 Ilya Matveev. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet var signInOutlet: UIButton!
    @IBOutlet var signUpOutlet: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        signInOutlet.layer.cornerRadius = 6
        signUpOutlet.layer.cornerRadius = 6

    }

}
