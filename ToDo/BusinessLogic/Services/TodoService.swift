//
//  TodoService.swift
//  ToDo
//
//  Created by Ilya Matveev on 02.12.2019.
//  Copyright © 2019 Ilya Matveev. All rights reserved.
//

import Foundation

final class TodoService {
    static let shared: TodoService = .init()

    private var items: [Todo] = [
        Todo(title: "Test todo"),
        Todo(title: "Test todo with date", date: Date(), isDone: true),
    ]

    private init() {
    }

    func getItems() -> [Todo] {
        return items
    }

    // TODO: Return optional
    func getItem(id: UUID) -> Todo {
        var index = false
        var item: Todo?
        for (counter, currentItem) in items.enumerated() where id == currentItem.id {
            item = items[counter]
            index = true
        }
        if index == true {
            guard let newItem = item else { fatalError("Failed") }
            return newItem
        } else {
            fatalError("Failed to search item")
        }
    }

    func save(item: Todo) {
        if let index = items.firstIndex(where: { item.id == $0.id }) {
            items[index] = item
        } else {
            items.append(item)
        }
        NotificationCenter.default.post(name: .update, object: nil)
    }

    func removeItem(at index: Int) {
        items.remove(at: index)
        NotificationCenter.default.post(name: .update, object: nil)
    }

    func moveItem(fromIndex: Int, toIndex: Int) {
        let from = items[fromIndex]
        items.remove(at: fromIndex)
        items.insert(from, at: toIndex)
        NotificationCenter.default.post(name: .update, object: nil)
    }

}
