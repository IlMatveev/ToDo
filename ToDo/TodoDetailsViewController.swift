//
//  TodoDetailsViewController.swift
//  ToDo
//
//  Created by Ilya Matveev on 06.12.2019.
//  Copyright © 2019 Ilya Matveev. All rights reserved.
//

import UIKit

final class TodoDetailsViewController: UIViewController {
    private let todoManager: TodoService = .shared

    @IBOutlet private var stateOutlet: UISwitch!
    @IBOutlet private var titleOutlet: UILabel!
    @IBOutlet private var dateOutlet: UILabel!

    // FIXME: force unwrap
    var currentItem: Todo!

    // MARK: - Lifecycle
    @IBAction func editAction(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "toEdit", sender: nil)
        
    }

    @IBAction func stateAction(_ sender: UISwitch) {
        currentItem?.isDone = stateOutlet.isOn
        todoManager.updateItem(item: currentItem)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(updateItem), name: NSNotification.Name(rawValue: "updateItem"), object: nil)

        dateOutlet.text = "Due date: \(todoManager.longDate(item: currentItem))"
        titleOutlet.text = "Title: \(currentItem.title)"
        stateOutlet.isOn = currentItem.isDone
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let addNavigationController = segue.destination as? UINavigationController,
            let addController = addNavigationController.viewControllers.first as? AddTodoViewController
        else { return }

        addController.newItem = currentItem
    }

    @objc func updateItem() {
        for item in todoManager.getItems() where currentItem.id == item.id {
            currentItem = item
        }

        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"

        dateOutlet.text = "Due date: \(todoManager.longDate(item: currentItem))"
        titleOutlet.text = "Title: \(currentItem.title)"
    }

}
