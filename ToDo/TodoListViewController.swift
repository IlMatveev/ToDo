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

class TodoListViewController: UITableViewController, TodoServiceDelegate {
    // MARK: - Dependencies
    private let todoSrv: TodoService = .shared
    private var items: [Todo] = []

    var currentFolder: Folder?

    // MARK: - Outlets
    // MARK: - Local Variables
    // MARK: - Lifecycle
    // MARK: - Actions
    // MARK: - Methods
    // MARK: - Rest думай сам

    override func viewDidLoad() {
        super.viewDidLoad()

        todoSrv.attach(self)

        updateData()
    }

    @IBAction func pushEditAction(_ sender: UIBarButtonItem) {
        tableView.setEditing(!tableView.isEditing, animated: true)
    }

    @IBAction func toAdd(_ sender: UIButton) {
        performSegue(withIdentifier: "toAdd", sender: nil)
    }

    // MARK: - Table view data source

    func update(subject: TodoService) {
        updateData()
    }

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

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if
            let selectedCellIndexRow = tableView.indexPathForSelectedRow?.row,
            let detailsController = segue.destination as? TodoDetailsViewController {
            detailsController.currentItem = items[selectedCellIndexRow]
        }
        
        if
            let navigationController = segue.destination as? UINavigationController,
            let addController = navigationController.topViewController as? AddTodoViewController {
            addController.currentFolder = currentFolder
        }
    }
    
}
