//
//  AddTodoViewController.swift
//  ToDo
//
//  Created by Ilya Matveev on 12.12.2019.
//  Copyright © 2019 Ilya Matveev. All rights reserved.
//

import UIKit

extension Optional {
    var isNone: Bool {
        return self == nil
    }
    var isSome: Bool {
        return self != nil
    }
}

final class AddTodoViewController: UIViewController {
    private let todoSrv: TodoService = .shared

    @IBOutlet private var textField: UITextField!
    @IBOutlet private var dateField: UITextField!
    @IBOutlet var toolBar: UIToolbar!
    @IBOutlet var datePicker: UIDatePicker!

    var currentFolder: Folder?
    var currentItem: Todo?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = currentItem.isNone
            ? "Add ToDo"
            : "Edit ToDo"

        textField.text = currentItem?.title
        dateField.text = currentItem?.itemLongDate()

        dateField.inputView = datePicker
        dateField.inputAccessoryView = toolBar
        textField.inputAccessoryView = toolBar
    }

    @IBAction func doneAction(_ sender: UIBarButtonItem) {
        view.endEditing(true)
    }

    @IBAction func datePickerAction(_ sender: UIDatePicker) {
        dateField.text = DateFormatter.long.string(from: datePicker.date)
    }

    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func saveAction(_ sender: UIBarButtonItem) {
        guard let title = textField.text else { return }

        var item = currentItem ?? Todo()
        item.folderId = currentFolder?.id
        item.title = title
        item.date = datePicker.date
        todoSrv.save(item: item) { _ in }
        dismiss(animated: true, completion: nil)
    }
}
