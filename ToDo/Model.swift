//
//  Model.swift
//  ToDo
//
//  Created by Ilya Matveev on 02.12.2019.
//  Copyright © 2019 Ilya Matveev. All rights reserved.
//

import Foundation

struct ToDoItem {
    var title: String
    // TODO: Use UUID type & remame to `id` & move to top
    var uuid: String
    var date: Date
}

final class ToDoManager {
    static let shared: ToDoManager = .init()

    var items: [ToDoItem] = []

    private init() {
    }

    func addItem(item: ToDoItem) {
        items.append(item)
    }

    func updateItem(item: ToDoItem) {
//        items.append(item)
    }

    func removeItem(at index: Int) {
        items.remove(at: index)
    }

    func moveItem(fromIndex: Int, toIndex: Int) {
        let from = items[fromIndex]
        items.remove(at: fromIndex)
        items.insert(from, at: toIndex)
    }
}
