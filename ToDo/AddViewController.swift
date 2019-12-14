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

    @IBAction func textAction(_ sender: UITextField) {
        newTitle = textField.text
    }
   
    @IBAction func addAction(_ sender: UIButton) {
        guard let title = newTitle, let date = newDate else {
            return
        }

        let newItem = ToDoItem(id: UUID(), title: title, date: date)
        todoManager.addItem(item: newItem)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "update"), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
