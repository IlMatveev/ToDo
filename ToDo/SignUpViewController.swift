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

    var currentUser: User?

    @IBOutlet var signUpOutlet: UIButton!
    @IBOutlet var toolBarOutlet: UIToolbar!
    @IBOutlet var loginOutlet: UITextField!
    @IBOutlet var passwordOutlet: UITextField!
    @IBOutlet var rePasswordOutlet: UITextField!
    @IBAction func signUpAction(_ sender: UIButton) {

    }

    override func viewDidLoad() {
        super.viewDidLoad()

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

}
