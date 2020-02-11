//
//  TodoService.swift
//  ToDo
//
//  Created by Ilya Matveev on 02.12.2019.
//  Copyright © 2019 Ilya Matveev. All rights reserved.
//

import Foundation

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
            Current.repository.update(item: item, in: .todos) { result in
                DispatchQueue.main.async {
                    self.delegate?.update(subject: self)
                    self.notify()
                    completion(result.mapError { $0 }.map({ $0 }))
                }
            }
        } else {
            Current.repository.save(item: item, to: .todos) { result in
                DispatchQueue.main.async {
                    self.delegate?.update(subject: self)
                    self.notify()
                    completion(result.mapError { $0 }.map { _ in () })
                }
            }
        }
    }

    func getItem(id: Todo.ID, idF: Folder.ID, completion: @escaping (Result<Todo, Error>) -> Void) {
        Current.repository.getOne(id: id, from: .todos(from: idF)) { result in
            DispatchQueue.main.async {
                completion(result.mapError { $0 })
            }
        }
    }

    func getItems(inFolder idF: Folder.ID, completion: @escaping (Result<[Todo], Error>) -> Void) {
        Current.repository.getAll(from: .todos(from: idF)) { result in
            DispatchQueue.main.async {
                completion(result.mapError { $0 })
            }
        }
    }

    func remove(item: Todo, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let id = item.id else { return }
        Current.repository.remove(id: id, from: .todos) { result in
            DispatchQueue.main.async {
                self.delegate?.update(subject: self)
                completion(result.mapError { $0 })
            }
        }
    }

}
