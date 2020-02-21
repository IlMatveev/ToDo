//
//  TodoDetailsViewController.swift
//  ToDo
//
//  Created by Ilya Matveev on 06.12.2019.
//  Copyright © 2019 Ilya Matveev. All rights reserved.
//

import UIKit

final class TodoDetailsViewController: UIViewController, TodoServiceDelegate, Storyboarded {
    struct Config {
        var editTapped: () -> Void
    }

    private let todoSrv: TodoService = .shared
    private let notificationCenter: NotificationCenter = .default

    @IBOutlet private var stateOutlet: UISwitch!
    @IBOutlet private var titleOutlet: UILabel!
    @IBOutlet private var dateOutlet: UILabel!

    private var configuration: Config?

    func configure(with config: Config) {
        configuration = config
    }

    var currentItem: Todo? {
        didSet {
            renderItem()
        }
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        renderItem()
    }

    func update(subject: TodoService) {
        updateItem()
    }

    private func renderItem () {
        guard let item = currentItem, isViewLoaded else { return }

        titleOutlet.text = "Title: \(item.title)"
        dateOutlet.text = "Due date: \(item.itemLongDate())"
        stateOutlet.isOn = item.isDone
    }

    @IBAction private func editAction(_ sender: UIBarButtonItem) {
        configuration?.editTapped()
    }

    @IBAction private func stateAction(_ sender: UISwitch) {
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
        guard
            let id = currentItem?.id,
            let idF = currentItem?.folderId
        else { return }

        todoSrv.getItem(id: id, idF: Folder.ID(rawValue: idF)) { result in
            switch result {
            case .success(let item):
                self.currentItem = item
            case .failure(let error):
                print(error)
            }
        }
    }

}
