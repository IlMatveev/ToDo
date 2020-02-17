//
//  AddFoldersViewController.swift
//  ToDo
//
//  Created by Ilya Matveev on 16.01.2020.
//  Copyright © 2020 Ilya Matveev. All rights reserved.
//

import UIKit

class AddFoldersViewController: UIViewController, Storyboarded {
    @IBOutlet var folderTitle: UITextField!
    @IBOutlet var toolbar: UIToolbar!

    var currentFolder: Folder?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = currentFolder.isNone
        ? "Add Folder"
        : "Edit Folder"

        folderTitle.text = currentFolder?.name

        folderTitle.inputAccessoryView = toolbar

    }

    @IBAction func done(_ sender: UIBarButtonItem) {
        view.endEditing(true)
    }

    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func saveAction(_ sender: UIBarButtonItem) {
        guard let title = folderTitle.text else { return }

        var folder = currentFolder ?? Folder()
        folder.name = title
        FolderService.shared.save(folder: folder) { _ in }
        dismiss(animated: true, completion: nil)
    }
    
}
