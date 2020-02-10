//
//  InMemoryRepository.swift
//  ToDo
//
//  Created by Ilya Matveev on 06.02.2020.
//  Copyright © 2020 Ilya Matveev. All rights reserved.
//

import Foundation
import Alamofire

final class InMemoryRepository {
    var data: [ObjectIdentifier: [String: [Any]]] = [:]

    func add<T: Entity>(items: [T], to collection: T.Collection) {
        data[ObjectIdentifier(T.self)] = [collection.path: items]
    }

    func delete<T: Entity>(collection: T.Collection) {
        data = [:]
    }

    func getAll<T: Entity>(from collection: T.Collection) -> [T]? {
        guard let items = data[ObjectIdentifier(T.self)]?[collection.path] as? [T] else {
            return nil
        }
        return items
    }

    func getOne<T: Entity>(from collection: T.Collection, id: T.ID) -> T? {
        guard let items = data[ObjectIdentifier(T.self)]?[collection.path] as? [T] else {
            return nil
        }
        return items.first { $0.id == id }
    }

    func remove<T: Entity>(from collection: T.Collection, id: T.ID) {
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

    func update<T: Entity>(from collection: T.Collection, item: T) {
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

    func save<T: Entity>(from collection: T.Collection, item: T) {
        guard let items = data[ObjectIdentifier(T.self)]?[collection.path] as? [T] else {
            fatalError("Items not found")
        }

        var all = items as Array
        all.append(item)

        data[ObjectIdentifier(T.self)] = [collection.path: all]
    }

}
