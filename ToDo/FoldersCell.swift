//
//  FoldersCell.swift
//  ToDo
//
//  Created by Ilya Matveev on 16.01.2020.
//  Copyright © 2020 Ilya Matveev. All rights reserved.
//

import UIKit

class FoldersCell: UITableViewCell {

    @IBOutlet var folderTitle: UILabel!
    @IBOutlet var folderAmount: UILabel!

    private var currentFolder: Folder?

    func fill(with folder: Folder) {
        let amount = currentFolder?.items?.count ?? 0
        folderTitle.text = folder.name
        folderAmount.text = String(amount)
        currentFolder = folder
    }
    
}
