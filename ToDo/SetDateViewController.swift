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
        currentItem?.state = stateOutlet.isOn
        todoManager.updateItem(item: currentItem)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "update"), object: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(updateItem), name: NSNotification.Name(rawValue: "updateItem"), object: nil)

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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let addNavigationController = segue.destination as? UINavigationController,
            let addController = addNavigationController.viewControllers.first as? AddViewController
        else { return }

        addController.newItem = currentItem
    }

    @objc func updateItem() {
        for item in todoManager.items where currentItem.id == item.id {
            currentItem = item
        }

        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        dateField.text = formatter.string(from: currentItem.date)
        textField.text = currentItem.title
    }

}
