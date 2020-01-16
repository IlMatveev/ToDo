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

    func getItem(item: Todo, completion: @escaping (Result<Todo, Error>) -> Void) {
        TodoRepository.shared.getItem(item: item) { result in
            DispatchQueue.main.async {
                completion(result.mapError { $0 })
            }
        }
    }

    func getItems(inFolder idF: Int, completion: @escaping (Result<[Todo], Error>) -> Void) {
        TodoRepository.shared.getItems(inFolder: idF) { result in
            DispatchQueue.main.async {
                completion(result.mapError { $0 })
            }
        }
    }

    func remove(item: Todo, completion: @escaping (Result<Void, Error>) -> Void) {
        TodoRepository.shared.remove(item: item) { result in
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: .update, object: nil)
                completion(result.mapError { $0 })
            }
        }
    }

}
