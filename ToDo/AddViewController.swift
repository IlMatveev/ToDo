//
//  AddViewController.swift
//  ToDo
//
//  Created by Ilya Matveev on 12.12.2019.
//  Copyright © 2019 Ilya Matveev. All rights reserved.
//

import UIKit

final class AddViewController: UIViewController {
    private let todoManager: ToDoManager = .shared

    @IBOutlet private var textField: UITextField!
    @IBOutlet private var dateField: UITextField!

    private let datePicker: UIDatePicker = .init()

    private var newTitle: String?
    private var newDate: Date?

    var newItem: ToDoItem?

    @IBAction func textAction(_ sender: UITextField) {
        newTitle = textField.text
    }

    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveAction(_ sender: UIBarButtonItem) {

        guard let title = newTitle, let date = newDate else {
            return
        }

        if newItem == nil {

            let newItem = ToDoItem(id: UUID(), title: title, date: date, state: false)

            todoManager.addItem(item: newItem)
        } else {

            newItem?.title = title
            newItem?.date = date

            guard let item = newItem else {return}

            todoManager.updateItem(item: item)
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateItem"), object: nil)
        }

        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "update"), object: nil)

        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if newItem != nil {
            self.title = "Edit ToDo"
        }

        if let item = newItem {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy"
            textField.text = item.title
            dateField.text = formatter.string(from: item.date)
        }

        datePicker.datePickerMode = .date

        dateField.inputView = datePicker

        let toolBar = UIToolbar()
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        toolBar.setItems([flexSpace, doneButton], animated: true)
        dateField.inputAccessoryView = toolBar
        textField.inputAccessoryView = toolBar

            datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
    }

    @objc func doneAction() {
        view.endEditing(true)
    }

    @objc func dateChanged() {
        getDateFromPicker()
    }

    @objc func getDateFromPicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        dateField.text = formatter.string(from: datePicker.date)
        newDate = datePicker.date
    }
}
