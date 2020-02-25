//
//  SignInViewController.swift
//  ToDo
//
//  Created by Ilya Matveev on 22.12.2019.
//  Copyright © 2019 Ilya Matveev. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, Storyboarded {
    struct Config {
        var signInTapped: () -> Void
    }

    private let userManager: UserService = .shared
    private let notificationCenter: NotificationCenter = .default
    
    @IBOutlet private var toolBarOutlet: UIToolbar!
    @IBOutlet private var checkOutlet: UILabel!
    @IBOutlet private var loginOutlet: UITextField!
    @IBOutlet private var passwordOutlet: UITextField!
    @IBOutlet private var signInOutlet: UIButton!
    @IBOutlet private var image: UIImageView!

    private var configuration: Config?

    func configure(with config: Config) {
        configuration = config
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        notificationCenter.addObserver(self, selector: #selector(viewChange), name: .kbWillChangeFrame, object: nil)

        navigationController?.setNavigationBarHidden(false, animated: false)

        signInOutlet.layer.cornerRadius = 6

        image.layer.cornerRadius = 8
        image.layer.shadowRadius = 5
        image.layer.shadowOffset = .zero
        image.layer.shadowOpacity = 1

        loginOutlet.inputAccessoryView = toolBarOutlet
        passwordOutlet.inputAccessoryView = toolBarOutlet
    }

    deinit {
        notificationCenter.removeObserver(self, name: .kbWillChangeFrame, object: nil)
    }

    @IBAction private func doneAction(_ sender: UIBarButtonItem) {
        view.endEditing(true)
    }

    @IBAction private func signInTapped(_ sender: UIButton) {
        guard
            let login = loginOutlet.text,
            let password = passwordOutlet.text
            else { return }

        UserService.shared.signIn(login: login, password: password) { result in
            switch result {
            case .success(let user):
                if user != nil {
                    self.configuration?.signInTapped()
                } else {
                    self.checkOutlet.text = "Incorrect login or password!"
                }
            case .failure(let error):
                print(error)
            }
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
