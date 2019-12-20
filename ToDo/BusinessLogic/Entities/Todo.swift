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
