//
//  TodoService.swift
//  ToDo
//
//  Created by Ilya Matveev on 02.12.2019.
//  Copyright © 2019 Ilya Matveev. All rights reserved.
//

import Foundation

protocol TodoObserver: class {
    func todosChanged()
}

final class TodoService {
    static let shared: TodoService = .init()

    private init() {
    }

    private struct WeakBox {
        weak var value: TodoObserver?
    }

    private var observers: [WeakBox] = []

    func notify() {
        observers.forEach { observer in
            observer.value?.todosChanged()
        }
    }

    func addObserver(observer: TodoObserver) {
        let currentObserver = WeakBox(value: observer)
        observers.append(currentObserver)
    }

    func removeObserver(observer: TodoObserver) {
        observers = observers.filter { $0.value !== observer }
    }

    func save(item: Todo, completion: @escaping (Result<Void, Error>) -> Void) {
        if item.id != nil {
            Current.repository.update(item: item, in: .todos) { result in
                DispatchQueue.main.async {
                    completion(result.mapError { $0 }.map({ $0 }))
                    self.notify()
                }
            }
        } else {
            Current.repository.save(item: item, to: .todos) { result in
                DispatchQueue.main.async {
                    completion(result.mapError { $0 }.map { _ in () })
                    self.notify()
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
                completion(result.mapError { $0 })
                self.notify()
            }
        }
    }

}
