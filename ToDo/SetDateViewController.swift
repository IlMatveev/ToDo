//
//  SetDateViewController.swift
//  ToDo
//
//  Created by Ilya Matveev on 06.12.2019.
//  Copyright © 2019 Ilya Matveev. All rights reserved.
//

import UIKit

final class SetDateViewController: UIViewController {
    private let todoManager: ToDoManager = .shared

    @IBOutlet private var textField: UITextField!
    @IBOutlet private var dateField: UITextField!
    @IBOutlet private var stateOutlet: UISwitch!

    var currentItem: ToDoItem!

    // MARK: - Lifecycle
    @IBAction func editAction(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "toEdit", sender: nil)
    }

    @IBAction func stateAction(_ sender: UISwitch) {
        stateOutlet.addTarget(self, action: #selector(stateChange), for: .valueChanged)
    }

    @objc func stateChange() {
        if stateOutlet.isOn == true {
            currentItem.state = true
        }
        else {
            currentItem.state = false
        }
        todoManager.updateItem(item: currentItem)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "update"), object: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        dateField.text = formatter.string(from: currentItem.date)

        textField.text = currentItem.title

        if currentItem.state == true {
            stateOutlet.isOn = true
        }
        else {
            stateOutlet.isOn = false
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
