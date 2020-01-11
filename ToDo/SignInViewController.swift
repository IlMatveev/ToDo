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
    private let notificationCenter: NotificationCenter = .default
    
    @IBOutlet var toolBarOutlet: UIToolbar!
    @IBOutlet var checkOutlet: UILabel!
    @IBOutlet var loginOutlet: UITextField!
    @IBOutlet var passwordOutlet: UITextField!
    @IBOutlet var signInOutlet: UIButton!
    @IBOutlet var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        notificationCenter.addObserver(self, selector: #selector(viewChange), name: .kbWillChangeFrame, object: nil)

        navigationController?.setNavigationBarHidden(false, animated: false)

        signInOutlet.layer.cornerRadius = 6

        image.layer.cornerRadius = 20
        image.layer.shadowPath = UIBezierPath(rect: image.bounds).cgPath
        image.layer.shadowRadius = 5
        image.layer.shadowOffset = .zero
        image.layer.shadowOpacity = 1

        loginOutlet.inputAccessoryView = toolBarOutlet
        passwordOutlet.inputAccessoryView = toolBarOutlet
    }

    deinit {
        notificationCenter.removeObserver(self, name: .kbWillChangeFrame, object: nil)
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

    @objc func viewChange(notification: NSNotification) {
        guard
            let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else { return }

        let keyboardFrameInView = view.convert(keyboardRect, from: nil)
        let safeAreaFrame = view.safeAreaLayoutGuide.layoutFrame.insetBy(dx: 0, dy: -additionalSafeAreaInsets.bottom)
        let intersection = safeAreaFrame.intersection(keyboardFrameInView)

        additionalSafeAreaInsets.bottom = intersection.height
        view.layoutIfNeeded()
    }

}
