//
//  SignUpViewController.swift
//  ToDo
//
//  Created by Ilya Matveev on 22.12.2019.
//  Copyright © 2019 Ilya Matveev. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    private let userManager: UserService = .shared

    // TODO: Избавиться от этого
    private var newLogin: String?
    private var newPassword: String?
    private var newRePassword: String?

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var signUpOutlet: UIButton!
    @IBOutlet var toolBarOutlet: UIToolbar!
    @IBOutlet var loginOutlet: UITextField!
    @IBOutlet var passwordOutlet: UITextField!
    @IBOutlet var rePasswordOutlet: UITextField!
    @IBOutlet var checkOutlet: UILabel!

    // TODO: Избавиться от этого
    @IBAction func loginAction(_ sender: UITextField) {
        newLogin = loginOutlet.text
    }

    @IBAction func passwordAction(_ sender: UITextField) {
        newPassword = passwordOutlet.text
    }

    @IBAction func rePasswordAction(_ sender: Any) {
        newRePassword = rePasswordOutlet.text
    }

    @IBAction func signUpAction(_ sender: UIButton) {
        if (newPassword == newRePassword) && (newLogin != nil) && (newPassword != nil) {
            guard
                let login = newLogin,
                let password = newPassword
            else { return }

            let user = User(login: login, password: password)

            userManager.addUser(user: user)

            self.navigationController?.popViewController(animated: true)
            dismiss(animated: true, completion: nil)
        } else {
            checkOutlet.text = "Error, check the data!"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(viewChange), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)

        navigationController?.setNavigationBarHidden(false, animated: false)

        signUpOutlet.layer.cornerRadius = 6

        toolBarOutlet.sizeToFit()

        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        toolBarOutlet.setItems([flexSpace, doneButton], animated: true)
        loginOutlet.inputAccessoryView = toolBarOutlet
        passwordOutlet.inputAccessoryView = toolBarOutlet
        rePasswordOutlet.inputAccessoryView = toolBarOutlet

    }

    @objc func doneAction() {
        view.endEditing(true)
    }

    @objc func viewChange(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            } else {self.view.frame.origin.y = 0}
        }
    }

}
