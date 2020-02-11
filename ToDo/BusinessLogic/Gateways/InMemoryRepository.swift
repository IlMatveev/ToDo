//
//  InMemoryRepository.swift
//  ToDo
//
//  Created by Ilya Matveev on 06.02.2020.
//  Copyright © 2020 Ilya Matveev. All rights reserved.
//

import Foundation
import Alamofire

final class InMemoryRepository: Repository {

    private var data: [ObjectIdentifier: [String: [Any]]] = [:]
    private var sequences: [ObjectIdentifier: Int] = [:]

    private let queue: DispatchQueue = .global()

    func newId<T: Entity>() -> T.ID {
        let number = sequences[ObjectIdentifier(T.self)] ?? 1

        sequences[ObjectIdentifier(T.self)] = number + 1

        return T.ID(rawValue: number)
    }

    func add<T: Entity>(items: [T], to collection: T.Collection) {
        data[ObjectIdentifier(T.self)] = [collection.path: items]
    }

    func delete<T: Entity>(collection: T.Collection) {
        data = [:]
    }

    func getAll<T: Entity>(from collection: T.Collection, completion: @escaping (Result<[T], RepositoryError>) -> Void) {
        let items = data[ObjectIdentifier(T.self)]?[collection.path] as? [T] ?? []
        completion(.success(items))
    }

    func getOne<T: Entity>(id: T.ID, from collection: T.Collection, completion: @escaping (Result<T, RepositoryError>) -> Void) {
        guard
            let items = data[ObjectIdentifier(T.self)]?[collection.path] as? [T],
            let item = (items.first { $0.id == id })
        else {
            fatalError("Not found id")
        }
        completion(.success(item))
    }

    func save<T: Entity>(item: T, to collection: T.Collection, completion: @escaping (Result<T, RepositoryError>) -> Void) {
        queue.async {
            let typeId = ObjectIdentifier(T.self)
            var typeCollections = self.data[typeId] ?? [:]
            var items = typeCollections[collection.path] as? [T] ?? []

            var newItem = item
            newItem.id = self.newId()

            if let index = items.firstIndex(where: { $0.id == item.id }) {
                items[index] = newItem
            } else {
                items.append(newItem)
            }

            typeCollections[collection.path] = items
            self.data[typeId] = typeCollections

            completion(.success(newItem))
        }
    }

    func update<T: Entity>(item: T, in collection: T.Collection, completion: @escaping (Result<T, RepositoryError>) -> Void) {
        guard
            let items = data[ObjectIdentifier(T.self)]?[collection.path] as? [T],
            let id = item.id,
            let index = items.firstIndex(where: {$0.id == id})
        else {
            fatalError("Items not found")
        }

        var all = items as Array
        all.insert(item, at: index)

        data[ObjectIdentifier(T.self)] = [collection.path: all]
    }

    func remove<T: Entity>(id: Identifier<T>, from collection: T.Collection, completion: @escaping (Result<Void, RepositoryError>) -> Void) {
        guard
            let items = data[ObjectIdentifier(T.self)]?[collection.path] as? [T],
            let index = items.firstIndex(where: {$0.id == id})
        else {
            fatalError("Items not found")
        }

        var all = items as Array
        all.remove(at: index)

        data[ObjectIdentifier(T.self)] = [collection.path: all]
    }

}
