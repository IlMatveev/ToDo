//
//  Todo.swift
//  ToDo
//
//  Created by Ilya Matveev on 20.12.2019.
//  Copyright © 2019 Ilya Matveev. All rights reserved.
//

import Foundation

struct Todo {
    var id: UUID
    var title: String
    var date: Date?
    var isDone: Bool
}

extension Todo {
    func itemShortDate() -> String {
        return self.date.map { DateFormatter.short.string(from: $0) } ?? ""
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
