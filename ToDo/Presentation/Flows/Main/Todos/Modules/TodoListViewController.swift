//
//  TodoListViewController.swift
//  ToDo
//
//  Created by Ilya Matveev on 02.12.2019.
//  Copyright © 2019 Ilya Matveev. All rights reserved.
//

import UIKit

extension NSNotification.Name {
    static let kbWillChangeFrame = UIResponder.keyboardWillChangeFrameNotification
}

class TodoListViewController: UITableViewController, TodoObserver, Storyboarded {

    // MARK: - Dependencies
    struct Config {
        var addTapped: () -> Void
        var cellTapped: (Todo) -> Void
    }

    var currentFolder: Folder?

    private let todoSrv: TodoService = .shared
    private var items: [Todo] = []
    private var configuration: Config?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = currentFolder?.name

        todoSrv.addObserver(observer: self)

        updateData()
    }

    @IBAction func pushEditAction(_ sender: UIBarButtonItem) {
        tableView.setEditing(!tableView.isEditing, animated: true)
    }

    @IBAction func toAdd(_ sender: UIButton) {
        configuration?.addTapped()
    }

    func configure(with config: Config) {
        configuration = config
    }

    func todosChanged() {
        updateData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return items.count
        } else {
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            guard let todoCell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomCell else {
                fatalError("Failed to dequeue custom cell")
            }
            todoCell.fill(with: items[indexPath.row])
            return todoCell
        } else {
            guard let addCell = tableView.dequeueReusableCell(withIdentifier: "AddCell", for: indexPath) as? AddCell else {
                fatalError("Failed to dequeue custom cell")
            }
            return addCell
        }
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todoSrv.remove(item: items[indexPath.row]) { _ in }
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        configuration?.cellTapped(items[indexPath.row])
    }

    func updateData() {
        guard let idF = currentFolder?.id else { return }
        todoSrv.getItems(inFolder: idF) { result in
            switch result {
            case .success(let items):
                self.items = items
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
