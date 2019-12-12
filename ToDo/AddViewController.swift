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
        if textField.text != nil {
        newTitle = textField.text
        }
    }
    @IBAction func addAction(_ sender: UIButton) {
        if (newTitle != nil) && (newDate != nil) {
            let newItem = ToDoItem(id: UUID(), title: newTitle!, date: newDate!)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        dateField.inputView = datePicker
        datePicker.datePickerMode = .date
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([flexSpace, doneButton], animated: true)
        dateField.inputAccessoryView = toolBar
        textField.inputAccessoryView = toolBar
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        textField.addTarget(self, action: #selector(textAction), for: .valueChanged)

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
