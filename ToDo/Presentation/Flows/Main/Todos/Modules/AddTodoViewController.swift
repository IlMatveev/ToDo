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

final class AddTodoViewController: UIViewController, Storyboarded {
    struct Config {
        var closeAddTapped: () -> Void
    }

    private let todoSrv: TodoService = .shared

    @IBOutlet private var textField: UITextField!
    @IBOutlet private var dateField: UITextField!
    @IBOutlet private var toolBar: UIToolbar!
    @IBOutlet private var datePicker: UIDatePicker!

    private var configuration: Config?

    func configure(with config: Config) {
        configuration = config
    }

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

    @IBAction private func doneAction(_ sender: UIBarButtonItem) {
        view.endEditing(true)
    }

    @IBAction private func datePickerAction(_ sender: UIDatePicker) {
        dateField.text = DateFormatter.long.string(from: datePicker.date)
    }

    @IBAction private func cancelAction(_ sender: UIBarButtonItem) {
        configuration?.closeAddTapped()
    }

    @IBAction private func saveAction(_ sender: UIBarButtonItem) {
        guard let title = textField.text else { return }

        var item = currentItem ?? Todo()
        item.folderId = (currentFolder?.id).map { $0.rawValue }
        item.title = title
        item.date = datePicker.date
        todoSrv.save(item: item) { _ in }
        configuration?.closeAddTapped()
    }
}
