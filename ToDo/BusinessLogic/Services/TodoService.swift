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
        DispatchQueue.main.async {
            TodoRepository.shared.getItems { result in
                switch result {
                case .success(let items):
                    completion(.success(items))
                case .failure(let error):
                    print(error)
                }
            }
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

    func save(item: Todo, completion: @escaping (Result<Void, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            if let index = self.items.firstIndex(where: { item.id == $0.id }) {
                self.items[index] = item
                completion(.success(()))
            } else {
                self.items.append(item)
                TodoRepository.shared.save(toSave: item) { result in
                    switch result {
                    case .success:
                        print("OK")
                    case .failure(let error):
                        print(error)
                    }
                }
                completion(.success(()))
            }
            NotificationCenter.default.post(name: .update, object: nil)
        }
    }

    func removeItem(id: UUID, completion: @escaping (Result<Void, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            TodoRepository.shared.remove(id: id) {_ in }
            NotificationCenter.default.post(name: .update, object: nil)
            completion(.success(()))
        }
    }

    func moveItem(fromIndex: Int, toIndex: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            let from = self.items[fromIndex]
            self.items.remove(at: fromIndex)
            self.items.insert(from, at: toIndex)
            NotificationCenter.default.post(name: .update, object: nil)
            completion(.success(()))
        }
    }

}
