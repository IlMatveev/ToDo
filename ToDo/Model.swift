//
//  Model.swift
//  ToDo
//
//  Created by Ilya Matveev on 02.12.2019.
//  Copyright © 2019 Ilya Matveev. All rights reserved.
//

import Foundation

struct ToDoItem {
    var id: UUID
    var title: String
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
        for (i, currentItem) in items.enumerated() {
            if item.id == currentItem.id {
                items[i] = item
            }
        }
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
