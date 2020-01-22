//
//  Todo.swift
//  ToDo
//
//  Created by Ilya Matveev on 20.12.2019.
//  Copyright © 2019 Ilya Matveev. All rights reserved.
//

import Foundation

struct Todo: Codable {
    var id: Int?
    var folderId: Int?
    var title: String = ""
    var date: Date?
    var isDone: Bool = false
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
