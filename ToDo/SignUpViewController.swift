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

    @IBOutlet var signUpOutlet: UIButton!
    @IBOutlet var toolBarOutlet: UIToolbar!
    @IBOutlet var loginOutlet: UITextField!
    @IBOutlet var passwordOutlet: UITextField!
    @IBOutlet var rePasswordOutlet: UITextField!
    @IBOutlet var checkOutlet: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(viewChange), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(viewChange), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(viewChange), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)

        navigationController?.setNavigationBarHidden(false, animated: false)

        signUpOutlet.layer.cornerRadius = 6

        loginOutlet.inputAccessoryView = toolBarOutlet
        passwordOutlet.inputAccessoryView = toolBarOutlet
        rePasswordOutlet.inputAccessoryView = toolBarOutlet

    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

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

    @IBAction func doneAction(_ sender: UIBarButtonItem) {
        view.endEditing(true)
    }

    @objc func viewChange(notification: NSNotification) {
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {return}

        if notification.name == UIResponder.keyboardWillShowNotification &&
        notification.name == UIResponder.keyboardWillChangeFrameNotification {
        view.frame.origin.y = -keyboardRect.height
        } else {
            view.frame.origin.y = 0
        }
    }

}
