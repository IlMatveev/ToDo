//
//  SignUpViewController.swift
//  ToDo
//
//  Created by Ilya Matveev on 22.12.2019.
//  Copyright © 2019 Ilya Matveev. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, Storyboarded {
    struct Config {
        var signUpTapped: () -> Void
    }

    private let userManager: UserService = .shared
    private let notificationCenter: NotificationCenter = .default
    private let scrollView = UIScrollView()

    @IBOutlet var signUpOutlet: UIButton!
    @IBOutlet var toolBarOutlet: UIToolbar!
    @IBOutlet var loginOutlet: UITextField!
    @IBOutlet var passwordOutlet: UITextField!
    @IBOutlet var rePasswordOutlet: UITextField!
    @IBOutlet var checkOutlet: UILabel!

    private var configuration: Config?

    func configure(with config: Config) {
        configuration = config
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        notificationCenter.addObserver(self, selector: #selector(viewChange), name: .kbWillChangeFrame, object: nil)

        navigationController?.setNavigationBarHidden(false, animated: false)

        signUpOutlet.layer.cornerRadius = 6

        loginOutlet.inputAccessoryView = toolBarOutlet
        passwordOutlet.inputAccessoryView = toolBarOutlet
        rePasswordOutlet.inputAccessoryView = toolBarOutlet

    }

    deinit {
        notificationCenter.removeObserver(self, name: .kbWillChangeFrame, object: nil)
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
