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
            TodoRepository.shared.save(toSave: item) {_ in }
        }
    }

    func fill(with item: Todo) {
        titleLabel.text = item.title
        dateLabel.text = item.formattedDate(format: .short)
        switchState.isOn = item.isDone
        currentItem = item
    }
}
