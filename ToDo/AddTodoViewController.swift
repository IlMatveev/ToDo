//
//  AddTodoViewController.swift
//  ToDo
//
//  Created by Ilya Matveev on 12.12.2019.
//  Copyright © 2019 Ilya Matveev. All rights reserved.
//

import UIKit

final class AddTodoViewController: UIViewController {
    private let todoManager: TodoService = .shared

    @IBOutlet private var textField: UITextField!
    @IBOutlet private var dateField: UITextField!
    @IBOutlet var toolBar: UIToolbar!
    @IBOutlet var datePicker: UIDatePicker!
    
    private var newTitle: String?
    private var newDate: Date?

    var newItem: Todo?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if newItem != nil {
            self.title = "Edit ToDo"
        }

        if let item = newItem {
            textField.text = item.title
            dateField.text = item.itemLongDate()
        }

        dateField.inputView = datePicker
        dateField.inputAccessoryView = toolBar
        textField.inputAccessoryView = toolBar

    }

    @IBAction func doneAction(_ sender: UIBarButtonItem) {
        view.endEditing(true)
    }

    @IBAction func datePickerAction(_ sender: UIDatePicker) {
        dateField.text = DateFormatter.long.string(from: datePicker.date)
        newDate = datePicker.date
    }

    @IBAction func textAction(_ sender: UITextField) {
        newTitle = textField.text
    }

    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func saveAction(_ sender: UIBarButtonItem) {

        guard let title = newTitle else {return}

        if newItem == nil {
            let newItem = Todo(id: UUID(), title: title, date: newDate, isDone: false)
            todoManager.updateItem(item: newItem)
        } else {
            newItem?.title = title
            newItem?.date = newDate
            guard let item = newItem else {return}
            todoManager.updateItem(item: item)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateItem"), object: nil)
        }
        dismiss(animated: true, completion: nil)
    }

}
