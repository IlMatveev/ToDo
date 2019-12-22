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
    private var newLogin: String?
    private var newPassword: String?

    var currentUser: User?
    
    @IBOutlet var checkOutlet: UILabel!
    @IBOutlet var loginOutlet: UITextField!
    @IBOutlet var passwordOutlet: UITextField!
    @IBOutlet var signInOutlet: UIButton!
    
    @IBAction func loginAction(_ sender: UITextField) {
        newLogin = loginOutlet.text
    }

    @IBAction func passwordAction(_ sender: UITextField) {
        newPassword = passwordOutlet.text
    }
    
    @IBAction func signInAction(_ sender: UIButton) {
        guard
            let login = newLogin,
            let password = newPassword
            else { return }

        currentUser?.login = login
        currentUser?.password = password

        guard let user = currentUser else { return }

        let check = userManager.checkUser(user: user)

        if check == true {
             performSegue(withIdentifier: "toToDo", sender: nil)
        } else {
            checkOutlet.text = "Incorrect login or password!"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        signInOutlet.layer.cornerRadius = 6
       
    }
    

    
}
