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

    func save(item: Todo) {
        if item.id != nil {
            TodoRepository.shared.update(toUpdate: item) {_ in
                NotificationCenter.default.post(name: .update, object: nil)
            }
        } else {
            TodoRepository.shared.save(toSave: item) {_ in
                NotificationCenter.default.post(name: .update, object: nil)
            }
        }
    }

    func getItem(id: String, completion: @escaping (Result<Todo, Error>) -> Void) {
        TodoRepository.shared.getItem(id: id) { result in
            switch result {
            case .success(let newItem):
                completion(.success(newItem))
              //  NotificationCenter.default.post(name: .update, object: nil)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getItems(_ completion: @escaping (Result<[Todo], Error>) -> Void) {
        TodoRepository.shared.getItems { result in
            switch result {
            case .success(let newItems):
                completion(.success(newItems))
                //NotificationCenter.default.post(name: .update, object: nil)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func remove(id: String) {
        TodoRepository.shared.remove(id: id) {_ in }
        NotificationCenter.default.post(name: .update, object: nil)
    }

    func moveItem(fromIndex: Int, toIndex: Int) {
        let from = self.items[fromIndex]
        self.items.remove(at: fromIndex)
        self.items.insert(from, at: toIndex)
        NotificationCenter.default.post(name: .update, object: nil)
    }

}
