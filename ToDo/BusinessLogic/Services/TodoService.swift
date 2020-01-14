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

    private init() {
    }

    func save(item: Todo, completion: @escaping (Result<Void, Error>) -> Void) {
        if item.id != nil {
            TodoRepository.shared.update(toUpdate: item) { result in
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: .update, object: nil)
                    completion(result.mapError { $0 })
                }
            }
        } else {
            TodoRepository.shared.save(toSave: item) { result in
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: .update, object: nil)
                    completion(result.mapError { $0 })
                }
            }
        }
    }

    func getItem(id: Int, completion: @escaping (Result<Todo, Error>) -> Void) {
        TodoRepository.shared.getItem(id: id) { result in
            DispatchQueue.main.async {
                completion(result.mapError { $0 })
            }
        }
    }

    func getItems(_ completion: @escaping (Result<[Todo], Error>) -> Void) {
        TodoRepository.shared.getItems { result in
            DispatchQueue.main.async {
                completion(result.mapError { $0 })
            }
        }
    }

    func remove(id: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        TodoRepository.shared.remove(id: id) { result in
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: .update, object: nil)
                completion(result.mapError { $0 })
            }
        }
    }

}
