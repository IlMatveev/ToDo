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

    func save(inFolder idF: Int, item: Todo, completion: @escaping (Result<Void, Error>) -> Void) {
        if item.id != nil {
            TodoRepository.shared.update(toUpdate: item, inFolder: idF) { result in
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: .update, object: nil)
                    completion(result.mapError { $0 })
                }
            }
        } else {
            TodoRepository.shared.save(toSave: item, inFolder: idF) { result in
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: .update, object: nil)
                    completion(result.mapError { $0 })
                }
            }
        }
    }

    func getItem(inFolder idF: Int, id: Int, completion: @escaping (Result<Todo, Error>) -> Void) {
        TodoRepository.shared.getItem(inFolder: idF, id: id) { result in
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

    func remove(inFolder idF: Int, id: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        TodoRepository.shared.remove(inFolder: idF, id: id) { result in
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: .update, object: nil)
                completion(result.mapError { $0 })
            }
        }
    }

}
