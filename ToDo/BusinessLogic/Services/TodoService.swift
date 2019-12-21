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

    private var items: [Todo] = []

    private init() {
    }

    func getItems() -> [Todo] {
        return items
    }

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

    func updateItem(item: Todo) {
        var index = false
        for (counter, currentItem) in items.enumerated() where item.id == currentItem.id {
            items[counter] = item
            index = true}
            if index == false {
                items.append(item)
            }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "update"), object: nil)
    }

    func removeItem(at index: Int) {
        items.remove(at: index)
    }

    func moveItem(fromIndex: Int, toIndex: Int) {
        let from = items[fromIndex]
        items.remove(at: fromIndex)
        items.insert(from, at: toIndex)
    }

    func shortDate (item: Todo) -> String {
        if item.date != nil {
            let formatter = DateFormatter()
            guard let date = item.date else {
                fatalError("Failed to dequeue date")
            }
            formatter.dateFormat = "dd.MM.yyyy"
            return formatter.string(from: date)} else {
            return ""
            }
    }

    func longDate (item: Todo) -> String {
        if item.date != nil {
           let formatter = DateFormatter()
           guard let date = item.date else {
               fatalError("Failed to dequeue date")
           }
           formatter.dateFormat = "dd MMMM yyyy"
            return formatter.string(from: date)} else {
            return ""
            }
    }

}
