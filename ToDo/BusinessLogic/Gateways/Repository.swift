//
//  Repository.swift
//  ToDo
//
//  Created by Ilya Matveev on 11.02.2020.
//  Copyright © 2020 Ilya Matveev. All rights reserved.
//

import Foundation

struct RepositoryError: Error {
    let underlyingError: Error
}

protocol Repository {
    func getAll<T: Entity>(from collection: T.Collection, completion: @escaping (Result<[T], RepositoryError>) -> Void)
    func getOne<T: Entity>(id: T.ID, from collection: T.Collection, completion: @escaping (Result<T, RepositoryError>) -> Void)

    func save<T: Entity>(item: T, to collection: T.Collection, completion: @escaping (Result<T, RepositoryError>) -> Void)
    func update<T: Entity>(item: T, in collection: T.Collection, completion: @escaping (Result<T, RepositoryError>) -> Void)

    func remove<T: Entity>(id: T.ID, from collection: T.Collection, completion: @escaping (Result<Void, RepositoryError>) -> Void)

    func getUser(login: String, password: String, completion: @escaping (Result<User?, RepositoryError>) -> Void)
}
