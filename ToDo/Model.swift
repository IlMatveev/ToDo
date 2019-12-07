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
    var date: Date
}

final class ToDoManager {
    static let shared: ToDoManager = .init()

    var items: [ToDoItem] = []
    
    private init() {
    }
    
    func addItem(item: ToDoItem) {
//        items
    }
    
    func removeItem(at index: Int) {
//        ToDoItems.remove(at: index)
    }
    
    func moveItem(fromIndex: Int, toIndex: Int) {
//        let from = ToDoItems[fromIndex]
//        ToDoItems.remove(at: fromIndex)
//        ToDoItems.insert(from, at: toIndex)
    }
}
