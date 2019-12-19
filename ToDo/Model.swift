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
    var state: Bool
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
        for (counter, currentItem) in items.enumerated() where item.id == currentItem.id {
            items[counter] = item
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
