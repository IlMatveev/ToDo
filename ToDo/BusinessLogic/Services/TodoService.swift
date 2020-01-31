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

protocol TodoServiceDelegate: class {
    func update(subject: TodoService)
}

final class TodoService {
    static let shared: TodoService = .init()

    private init() {
    }

    private lazy var observers: [TodoServiceDelegate] = []

    weak var delegate: TodoServiceDelegate?

    func attach(_ observer: TodoServiceDelegate) {
        observers.append(observer)
    }

    func detach(_ observer: TodoServiceDelegate) {
        if let idx = observers.firstIndex(where: { $0 === observer }) {
            observers.remove(at: idx)
        }
    }

    func notify() {
        observers.forEach({ $0.update(subject: self)})
    }

    func save(item: Todo, completion: @escaping (Result<Void, Error>) -> Void) {
        if item.id != nil {
            TodoRepository.shared.update(toUpdate: item) { result in
                DispatchQueue.main.async {
                    self.delegate?.update(subject: self)
                    self.notify()
                    completion(result.mapError { $0 })
                }
            }
        } else {
            TodoRepository.shared.save(toSave: item) { result in
                DispatchQueue.main.async {
                    self.delegate?.update(subject: self)
                    self.notify()
                    completion(result.mapError { $0 })
                }
            }
        }
    }

    func getItem(id: Int, idF: Int, completion: @escaping (Result<Todo, Error>) -> Void) {
        TodoRepository.shared.getItem(id: id, idF: idF) { result in
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
                self.delegate?.update(subject: self)
                completion(result.mapError { $0 })
            }
        }
    }

}
