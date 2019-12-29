//
//  SignInViewController.swift
//  ToDo
//
//  Created by Ilya Matveev on 22.12.2019.
//  Copyright © 2019 Ilya Matveev. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    private let userManager: UserService = .shared

    @IBOutlet var toolBarOutlet: UIToolbar!
    @IBOutlet var checkOutlet: UILabel!
    @IBOutlet var loginOutlet: UITextField!
    @IBOutlet var passwordOutlet: UITextField!
    @IBOutlet var signInOutlet: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(false, animated: false)

        signInOutlet.layer.cornerRadius = 6

        loginOutlet.inputAccessoryView = toolBarOutlet
        passwordOutlet.inputAccessoryView = toolBarOutlet
    }

    @IBAction func doneAction(_ sender: UIBarButtonItem) {
        view.endEditing(true)
    }

    @IBAction func signInAction(_ sender: UIButton) {
        guard
            let login = loginOutlet.text,
            let password = passwordOutlet.text
            else { return }

        let user = User(login: login, password: password)

        let check = userManager.checkUser(user: user)

        if check == true {
             performSegue(withIdentifier: "toToDo", sender: nil)
        } else {
            checkOutlet.text = "Incorrect login or password!"
        }
    }

}
