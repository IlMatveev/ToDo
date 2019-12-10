//
//  SetDateViewController.swift
//  ToDo
//
//  Created by Ilya Matveev on 06.12.2019.
//  Copyright © 2019 Ilya Matveev. All rights reserved.
//

import UIKit

final class SetDateViewController: UIViewController {
    private let todoManager: ToDoManager = .shared
    @IBOutlet private var dateField: UITextField!
    private let datePicker: UIDatePicker = .init()
    var currentDate: String
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
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
    }
    @objc func doneAction(){
        view.endEditing(true)
    }
    @objc func dateChanged(){
        getDateFromPicker()
    }
    func getDateFromPicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyy"
        dateField.text = formatter.string(from: datePicker.date)
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
