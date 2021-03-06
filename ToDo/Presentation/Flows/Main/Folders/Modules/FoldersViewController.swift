//
//  FoldersViewController.swift
//  ToDo
//
//  Created by Ilya Matveev on 16.01.2020.
//  Copyright © 2020 Ilya Matveev. All rights reserved.
//

import UIKit

class FoldersViewController: UITableViewController, FolderObserver, Storyboarded {
    struct Config {
        var newFolderTapped: () -> Void
        var cellTapped: (Folder) -> Void
        var logOutTapped: () -> Void
    }

    private let fldSrv: FolderService = .shared
    private var currentUser: User?
    private var folders: [Folder] = []

    private var configuration: Config?

    override func viewDidLoad() {
        super.viewDidLoad()

        fldSrv.addObserver(observer: self)

        updateData()

        self.navigationItem.hidesBackButton = true
    }

    @IBAction private func logOutTapped(_ sender: UIBarButtonItem) {
        UserService.shared.logOut { _ in }
        configuration?.logOutTapped()
    }

    @IBAction private func newFolderTapped(_ sender: UIBarButtonItem) {
        configuration?.newFolderTapped()
    }

    private func updateData() {
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

    func configure(with config: Config) {
        configuration = config
    }

    func foldersChanged() {
        updateData()
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
        configuration?.cellTapped(folders[indexPath.row])
    }

}
