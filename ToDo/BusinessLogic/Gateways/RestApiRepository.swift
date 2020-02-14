//
//  RestApiRepository.swift
//  ToDo
//
//  Created by Ilya Matveev on 05.02.2020.
//  Copyright © 2020 Ilya Matveev. All rights reserved.
//

import Foundation
import Alamofire

extension RepositoryError {
    var alamofireError: AFError? {
        return underlyingError as? AFError
    }
}

final class RestApiRepository: Repository {
    
    let session: Session = .default

    let backendUrl: String

    init(backendUrl: String) {
        self.backendUrl = backendUrl
    }

    func getAll<T: Entity>(from collection: T.Collection, completion: @escaping (Result<[T], RepositoryError>) -> Void) {
        session
            .request("\(backendUrl)\(collection.path)", method: .get)
            .validate()
            .responseDecodable(of: [T].self) { response in
                completion(response.result.mapError(RepositoryError.init))
            }
    }

    func getOne<T: Entity>(id: T.ID, from collection: T.Collection, completion: @escaping (Result<T, RepositoryError>) -> Void) {
        session
            .request("\(backendUrl)\(collection.path)\(id)", method: .get)
            .validate()
            .responseDecodable(of: T.self) { response in
                completion(response.result.mapError(RepositoryError.init))
            }
    }

    func save<T: Entity>(item: T, to collection: T.Collection, completion: @escaping (Result<T, RepositoryError>) -> Void) {
        session
            .request("\(backendUrl)\(collection.path)", method: .post, parameters: item)
            .validate()
            .responseDecodable(of: T.self) { response in
                completion(response.result.mapError(RepositoryError.init))
            }
    }

    func update<T: Entity>(item: T, in collection: T.Collection, completion: @escaping (Result<T, RepositoryError>) -> Void) {
        guard let id = item.id else {
            fatalError("Not found id")
        }
        session
            .request("\(backendUrl)\(collection.path)\(id)", method: .put, parameters: item)
            .validate()
            .responseDecodable(of: T.self) { response in
                completion(response.result.mapError(RepositoryError.init))
            }
    }

    func remove<T: Entity>(id: T.ID, from collection: T.Collection, completion: @escaping (Result<Void, RepositoryError>) -> Void) {
        session
            .request("\(backendUrl)\(collection.path)\(id)", method: .delete)
            .validate()
            .responseDecodable(of: T.self) { response in
                completion(response.result.map { data -> Void in () }.mapError(RepositoryError.init))
            }
    }

}