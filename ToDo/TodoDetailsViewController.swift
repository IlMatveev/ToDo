//
//  TodoDetailsViewController.swift
//  ToDo
//
//  Created by Ilya Matveev on 06.12.2019.
//  Copyright © 2019 Ilya Matveev. All rights reserved.
//

import UIKit

final class TodoDetailsViewController: UIViewController {
    private let todoSrv: TodoService = .shared
    private let notificationCenter: NotificationCenter = .default

    @IBOutlet private var stateOutlet: UISwitch!
    @IBOutlet private var titleOutlet: UILabel!
    @IBOutlet private var dateOutlet: UILabel!

    var currentItem: Todo? {
        didSet {
            renderItem()
        }
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        renderItem()

        notificationCenter.addObserver(self, selector: #selector(updateItem), name: .update, object: nil)
    }

    private func renderItem () {
        guard let item = currentItem, isViewLoaded else { return }

        titleOutlet.text = "Title: \(item.title)"
        dateOutlet.text = "Due date: \(item.itemLongDate())"
        stateOutlet.isOn = item.isDone
    }

    @IBAction func editAction(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "toEdit", sender: nil)

    }

    @IBAction func stateAction(_ sender: UISwitch) {
        currentItem?.isDone = stateOutlet.isOn
        guard let item = currentItem else {return}
        todoSrv.save(item: item) { _ in }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let addNavigationController = segue.destination as? UINavigationController,
            let addController = addNavigationController.viewControllers.first as? AddTodoViewController
        else { return }

        addController.currentItem = currentItem
    }

    @objc func updateItem() {
        guard let currentId = currentItem?.id else { return }

        todoSrv.getItem(id: currentId) { result in
            switch result {
            case .success(let item):
                self.currentItem = item
            case .failure(let error):
                print(error)
            }
        }
    }
}
