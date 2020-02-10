//
//  RestApiRepository.swift
//  ToDo
//
//  Created by Ilya Matveev on 05.02.2020.
//  Copyright © 2020 Ilya Matveev. All rights reserved.
//

import Foundation
import Alamofire

protocol Repository {
    func getAll<T: Entity>(from collection: T.Collection, completion: @escaping (Result<[T], AFError>) -> Void)
    func getOne<T: Entity>(from collection: T.Collection, id: T.ID, completion: @escaping (Result<T, AFError>) -> Void)
    func save<T: Entity>(from collection: T.Collection, item: T, completion: @escaping (Result<T, AFError>) -> Void)
    func update<T: Entity>(from collection: T.Collection, item: T, completion: @escaping (Result<Void, AFError>) -> Void)
    func remove<T: Entity>(from collection: T.Collection, id: T.ID, completion: @escaping (Result<Void, AFError>) -> Void)
}

final class RestApiRepository: Repository {
    
    let session: Session = .default

    let backendUrl: String

    init(backendUrl: String) {
        self.backendUrl = backendUrl
    }

    func getAll<T: Entity>(from collection: T.Collection, completion: @escaping (Result<[T], AFError>) -> Void) {
        session
            .request("\(backendUrl)\(collection.path)", method: .get)
            .validate()
            .responseDecodable(of: [T].self) { response in
                completion(response.result)
            }
    }

    func getOne<T: Entity>(from collection: T.Collection, id: T.ID, completion: @escaping (Result<T, AFError>) -> Void) {
        session
            .request("\(backendUrl)\(collection.path)\(id)", method: .get)
            .validate()
            .responseDecodable(of: T.self) { response in
                completion(response.result)
            }
    }

    func save<T: Entity>(from collection: T.Collection, item: T, completion: @escaping (Result<T, AFError>) -> Void) {
        session
            .request("\(backendUrl)\(collection.path)", method: .post, parameters: item)
            .validate()
            .responseDecodable(of: T.self) { response in
                completion(response.result)
            }
    }

    func update<T: Entity>(from collection: T.Collection, item: T, completion: @escaping (Result<Void, AFError>) -> Void) {
        guard let id = item.id else {
            fatalError("Not found id")
        }
        session
            .request("\(backendUrl)\(collection.path)\(id)", method: .put, parameters: item)
            .validate()
            .responseDecodable(of: T.self) { response in
                completion(response.result.map { data -> Void in () })
            }
    }

    func remove<T: Entity>(from collection: T.Collection, id: T.ID, completion: @escaping (Result<Void, AFError>) -> Void) {
        session
            .request("\(backendUrl)\(collection.path)\(id)", method: .delete)
            .validate()
            .responseDecodable(of: T.self) { response in
                completion(response.result.map { data -> Void in () })
            }
    }

}
