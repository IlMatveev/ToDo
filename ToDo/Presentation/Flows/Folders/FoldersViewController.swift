//
//  FoldersViewController.swift
//  ToDo
//
//  Created by Ilya Matveev on 16.01.2020.
//  Copyright © 2020 Ilya Matveev. All rights reserved.
//

import UIKit

class FoldersViewController: UITableViewController {

    private var folders: [Folder] = []

    @IBAction func toAddFolder(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "toAddFolder", sender: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        updateData()

        self.navigationItem.hidesBackButton = true

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return folders.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FoldersCell", for: indexPath) as? FoldersCell else {
            fatalError("Failed to dequeue folders cell")
        }

        cell.fill(with: folders[indexPath.row])

        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let id = folders[indexPath.row].id else { return }
            FolderService.shared.remove(id: id) { _ in }
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func updateData() {
        FolderService.shared.getFolders { result in
            switch result {
            case .success(let folders):
                self.folders = folders
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let selectedCellIndexRow = tableView.indexPathForSelectedRow?.row,
            let listController = segue.destination as? TodoListViewController
        else { return }

        listController.currentFolder = folders[selectedCellIndexRow]
    }

}
