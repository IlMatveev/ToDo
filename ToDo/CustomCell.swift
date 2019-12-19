//
//  CustomCell.swift
//  ToDo
//
//  Created by Ilya Matveev on 16.12.2019.
//  Copyright © 2019 Ilya Matveev. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    private let todoManager: ToDoManager = .shared

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var switchState: UISwitch!

    private var currentItem: ToDoItem?

    @IBAction func switchAction(_ sender: UISwitch) {
        currentItem?.state = sender.isOn

        if let item = currentItem {
            todoManager.updateItem(item: item)
        }
    }

    func setCell(item: ToDoItem) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        titleLabel.text = item.title
        dateLabel.text = formatter.string(from: item.date)
        switchState.isOn = item.state
        currentItem = item
    }
}
