//
//  AddFoldersViewController.swift
//  ToDo
//
//  Created by Ilya Matveev on 16.01.2020.
//  Copyright © 2020 Ilya Matveev. All rights reserved.
//

import UIKit

final class AddFoldersViewController: UIViewController, Storyboarded {
    @IBOutlet private var folderTitle: UITextField!
    @IBOutlet private var toolbar: UIToolbar!

    override func viewDidLoad() {
        super.viewDidLoad()

        folderTitle.inputAccessoryView = toolbar
    }

    @IBAction private func done(_ sender: UIBarButtonItem) {
        view.endEditing(true)
    }

    @IBAction private func cancelTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction private func saveTapped(_ sender: UIBarButtonItem) {
        guard let title = folderTitle.text else { return }
        let folder = Folder(id: nil, name: title)
        FolderService.shared.save(folder: folder) { _ in
            self.dismiss(animated: true, completion: nil)
        }
    }

}
