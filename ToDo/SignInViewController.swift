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

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(false, animated: false)

        signInOutlet.layer.cornerRadius = 6

        toolBarOutlet.sizeToFit()

        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        toolBarOutlet.setItems([flexSpace, doneButton], animated: true)
        loginOutlet.inputAccessoryView = toolBarOutlet
        passwordOutlet.inputAccessoryView = toolBarOutlet
    }

    @objc func doneAction() {
           view.endEditing(true)
       }
}
