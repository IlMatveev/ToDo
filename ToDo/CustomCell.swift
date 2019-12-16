//
//  CustomCell.swift
//  ToDo
//
//  Created by Ilya Matveev on 16.12.2019.
//  Copyright © 2019 Ilya Matveev. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    func setCell(item: ToDoItem) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"

        titleLabel.text = item.title
        dateLabel.text = formatter.string(from: item.date)
    }

}
