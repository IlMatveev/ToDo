//
//  TodoService.swift
//  ToDo
//
//  Created by Ilya Matveev on 02.12.2019.
//  Copyright © 2019 Ilya Matveev. All rights reserved.
//

import Foundation

enum ServiceError: Error {
    case searchProblem
}

final class TodoService {
    static let shared: TodoService = .init()

    private var items: [Todo] = [
        Todo(title: "Test todo"),
        Todo(title: "Test todo with date", date: Date(), isDone: true),
    ]

    private init() {
    }

    func moveItem(fromIndex: Int, toIndex: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        DispatchQueue.main.async {
            let from = self.items[fromIndex]
            self.items.remove(at: fromIndex)
            self.items.insert(from, at: toIndex)
            completion(.success(()))
        }
        NotificationCenter.default.post(name: .update, object: nil)
    }

}
