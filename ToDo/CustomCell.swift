//
//  CustomCell.swift
//  ToDo
//
//  Created by Ilya Matveev on 16.12.2019.
//  Copyright © 2019 Ilya Matveev. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    private let todoManager: TodoService = .shared

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var switchState: UISwitch!

    private var currentItem: Todo?

    @IBAction func switchAction(_ sender: UISwitch) {
        currentItem?.isDone = sender.isOn

        if let item = currentItem {
            todoManager.updateItem(item: item)
        }
    }

    func setCell(item: Todo) {
        titleLabel.text = item.title
        dateLabel.text = todoManager.shortDate(item: item)
        switchState.isOn = item.isDone
        currentItem = item
    }
}
