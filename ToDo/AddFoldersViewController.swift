//
//  AddFoldersViewController.swift
//  ToDo
//
//  Created by Ilya Matveev on 16.01.2020.
//  Copyright © 2020 Ilya Matveev. All rights reserved.
//

import UIKit

class AddFoldersViewController: UIViewController {
    @IBOutlet var folderTitle: UITextField!
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func saveAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
}
