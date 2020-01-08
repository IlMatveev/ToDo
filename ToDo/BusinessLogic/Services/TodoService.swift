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
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            var item: Todo
            for (counter, currentItem) in self.items.enumerated() where id == currentItem.id {
                item = self.items[counter]
                return completion(.success(item))
            }
            return completion(.failure(.searchProblem))
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
