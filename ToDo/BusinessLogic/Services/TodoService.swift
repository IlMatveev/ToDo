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

    func getItems(completion: @escaping (Result<[Todo], Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            completion(.success(self.items))
        }
    }

    func getItem(id: UUID, completion: @escaping (Result<Todo, ServiceError>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now()+5) {
            if let item = self.items.first(where: { id == $0.id }) {
                DispatchQueue.main.async {
                    completion(.success(item))
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(.searchProblem))
                }
            }
        }
    }

    func save(item: Todo, completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            if let index = self.items.firstIndex(where: { item.id == $0.id }) {
                self.items[index] = item
                completion()
            } else {
                self.items.append(item)
                completion()
            }
            NotificationCenter.default.post(name: .update, object: nil)
        }
    }

    func removeItem(at index: Int, completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.items.remove(at: index)
            NotificationCenter.default.post(name: .update, object: nil)
        }
    }

    func moveItem(fromIndex: Int, toIndex: Int, completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            let from = self.items[fromIndex]
            self.items.remove(at: fromIndex)
            self.items.insert(from, at: toIndex)
        NotificationCenter.default.post(name: .update, object: nil)
        }
    }

}
