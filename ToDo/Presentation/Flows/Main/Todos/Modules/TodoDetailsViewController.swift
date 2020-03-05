//
//  TodoDetailsViewController.swift
//  ToDo
//
//  Created by Ilya Matveev on 06.12.2019.
//  Copyright © 2019 Ilya Matveev. All rights reserved.
//

import UIKit

final class TodoDetailsViewController: UIViewController, Storyboarded {
    struct Config {
        var editTapped: () -> Void
    }

    private let todoSrv: TodoService = .shared

    @IBOutlet private var stateOutlet: UISwitch!
    @IBOutlet private var titleOutlet: UILabel!
    @IBOutlet private var dateOutlet: UILabel!

    private var configuration: Config?

    var currentFolder: Folder?
    var currentItem: Todo? {
        didSet {
            renderItem()
        }
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        renderItem()
    }

    func configure(with config: Config) {
        configuration = config
    }

    private func renderItem () {
        guard let item = currentItem, isViewLoaded else { return }

        titleOutlet.text = "Title: \(item.title)"
        dateOutlet.text = "Due date: \(item.itemLongDate())"
        stateOutlet.isOn = item.isDone
    }

    @IBAction private func editAction(_ sender: UIBarButtonItem) {
        configuration?.editTapped()
    }

    @IBAction private func stateAction(_ sender: UISwitch) {
        currentItem?.isDone = stateOutlet.isOn
        guard let item = currentItem else {return}
        todoSrv.save(item: item) { _ in }
    }

}
