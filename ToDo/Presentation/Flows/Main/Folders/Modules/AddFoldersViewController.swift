//
//  AddFoldersViewController.swift
//  ToDo
//
//  Created by Ilya Matveev on 16.01.2020.
//  Copyright © 2020 Ilya Matveev. All rights reserved.
//

import UIKit

final class AddFoldersViewController: UIViewController, Storyboarded {
    struct Config {
        var closeAddTapped: () -> Void
    }

    @IBOutlet private var folderTitle: UITextField!
    @IBOutlet private var toolbar: UIToolbar!

    private var configuration: Config?

    func configure(with config: Config) {
        configuration = config
    }

    var currentFolder: Folder?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = currentFolder.isNone
        ? "Add Folder"
        : "Edit Folder"

        folderTitle.text = currentFolder?.name

        folderTitle.inputAccessoryView = toolbar

    }

    @IBAction private func done(_ sender: UIBarButtonItem) {
        view.endEditing(true)
    }

    @IBAction private func cancelTapped(_ sender: UIBarButtonItem) {
        configuration?.closeAddTapped()
    }

    @IBAction private func saveTapped(_ sender: UIBarButtonItem) {
        guard let title = folderTitle.text else { return }

        var folder = currentFolder ?? Folder()
        folder.name = title
        FolderService.shared.save(folder: folder) { _ in }
        configuration?.closeAddTapped()
    }
    
}
