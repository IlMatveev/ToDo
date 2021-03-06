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

    private var currentFolder: Folder?

    func fill(with folder: Folder) {
        folderTitle.text = folder.name
        currentFolder = folder
    }
    
}
