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

    var currentItem: Todo?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(updateItem), name: NSNotification.Name(rawValue: "updateItem"), object: nil)

        updateItem()
    }

    @IBAction func editAction(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "toEdit", sender: nil)

    }

    @IBAction func stateAction(_ sender: UISwitch) {
        currentItem?.isDone = stateOutlet.isOn
        guard let item = currentItem else {return}
        todoManager.updateItem(item: item)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let addNavigationController = segue.destination as? UINavigationController,
            let addController = addNavigationController.viewControllers.first as? AddTodoViewController
        else { return }

        addController.newItem = currentItem
    }

    @objc func updateItem() {
        let currentId = currentItem?.id
        for item in todoManager.getItems() where currentId == item.id {
            currentItem = item
        }
        guard let item = currentItem else {return}
        titleOutlet.text = "Title: \(item.title)"
        dateOutlet.text = "Due date: \(item.itemLongDate())"
        stateOutlet.isOn = item.isDone
    }

}
