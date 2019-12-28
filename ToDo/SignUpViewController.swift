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

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var signUpOutlet: UIButton!
    @IBOutlet var toolBarOutlet: UIToolbar!
    @IBOutlet var loginOutlet: UITextField!
    @IBOutlet var passwordOutlet: UITextField!
    @IBOutlet var rePasswordOutlet: UITextField!
    @IBOutlet var checkOutlet: UILabel!

    @IBAction func signUpAction(_ sender: UIButton) {
        if passwordOutlet.text == rePasswordOutlet.text {
            guard
                let login = loginOutlet.text,
                let password = passwordOutlet.text
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
