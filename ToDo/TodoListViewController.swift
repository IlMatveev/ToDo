//
//  TodoListViewController.swift
//  ToDo
//
//  Created by Ilya Matveev on 02.12.2019.
//  Copyright © 2019 Ilya Matveev. All rights reserved.
//

import UIKit

extension NSNotification.Name {
    static let update: NSNotification.Name = .init("update")
    static let kbWillChangeFrame = UIResponder.keyboardWillChangeFrameNotification
}

class TodoListViewController: UITableViewController {
    // MARK: - Dependencies
    private let notificationCenter: NotificationCenter = .default
    private let todoSrv: TodoService = .shared
    private var items: [Todo] = []

    // MARK: - Outlets
    // MARK: - Local Variables
    // MARK: - Lifecycle
    // MARK: - Actions
    // MARK: - Methods
    // MARK: - Rest думай сам

    override func viewDidLoad() {
        super.viewDidLoad()

        updateData()

        notificationCenter.addObserver(self, selector: #selector(updateData), name: .update, object: nil)
    }

    @IBAction func pushEditAction(_ sender: UIBarButtonItem) {
        tableView.setEditing(!tableView.isEditing, animated: true)
    }

    @IBAction func toAdd(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "toAdd", sender: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomCell else {
            fatalError("Failed to dequeue custom cell")
        }

        cell.fill(with: items[indexPath.row])

        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let currentId = items[indexPath.row].id else { return }
            todoSrv.remove(id: currentId) { _ in }
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

//    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
//        todoSrv.moveItem(fromIndex: fromIndexPath.row, toIndex: to.row)
//    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let selectedCellIndexRow = tableView.indexPathForSelectedRow?.row,
            let detailsController = segue.destination as? TodoDetailsViewController
        else { return }

        detailsController.currentItem = items[selectedCellIndexRow]
    }

    @objc func updateData() {
        todoSrv.getItems { result in
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
