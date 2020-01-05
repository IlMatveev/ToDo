//
//  Todo.swift
//  ToDo
//
//  Created by Ilya Matveev on 20.12.2019.
//  Copyright © 2019 Ilya Matveev. All rights reserved.
//

import Foundation

struct Todo {
    var id: UUID = .init()
    var title: String = ""
    var date: Date?
    var isDone: Bool = false
}

struct cTodo: Codable {
    var cId: String
    var cTitle: String
    var cDate: String
    var cIsDone: String
}

func toCodable (item: Todo) -> cTodo {
    let newId = item.id.uuidString
    let newDate = item.formattedShortDate() ?? ""
    let newIsDone = String(item.isDone)
    let newTodo = cTodo(cId: newId, cTitle: item.title, cDate: newDate, cIsDone: newIsDone)
    return newTodo
}

func encode(to item: Todo) -> Data? {
    let newItem = toCodable(item: item)
    let encodedItem = try? JSONEncoder().encode(newItem)
    return encodedItem
}

func decode(from data: Data) -> cTodo {
    let newItem = try! JSONDecoder().decode(cTodo.self, from: data)
    return newItem
}


extension Todo {
    enum DateFormat {
        case short
        case long
    }

    func formattedDate(format: DateFormat) -> String? {
        switch format {
        case .short:
            return date.map(DateFormatter.short.string)
        case .long:
            return date.map(DateFormatter.long.string)
        }
    }
    
    func formattedShortDate() -> String? {
        return date.map(DateFormatter.short.string)
    }

    func itemLongDate() -> String {
        return self.date.map { DateFormatter.long.string(from: $0) } ?? ""
    }
}

extension DateFormatter {
    static let short: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .short
        return formatter
    }()

    static let long: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .long
        return formatter
    }()
}
