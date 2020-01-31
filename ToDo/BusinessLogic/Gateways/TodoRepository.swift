//
//  TodoRepository.swift
//  ToDo
//
//  Created by Ilya Matveev on 07.01.2020.
//  Copyright © 2020 Ilya Matveev. All rights reserved.
//

import Foundation
import Alamofire

enum APIError: Error {
    case responseProblem
    case decodingProblem
    case encodingProblem
}

final class TodoRepository {
    static let shared: TodoRepository = .init()

    let session: Session = .default

    private init() {
    }

    func save(toSave item: Todo, completion: @escaping (Result<Todo, AFError>) -> Void) {
        session
        .request("\(Current.backendUrl)/items", method: .post, parameters: item)
        .validate()
        .responseDecodable(of: Todo.self) { response in
            completion(response.result)
        }
    }

    func update(toUpdate item: Todo, completion: @escaping (Result<Todo, AFError>) -> Void) {
        guard
            let idF = item.folderId,
            let id = item.id
            else { return }
        session
            .request("\(Current.backendUrl)folders/\(idF)/items/\(id)", method: .put, parameters: item)
            .validate()
            .responseDecodable(of: Todo.self) { response in
                completion(response.result)
        }
    }

    func remove(item: Todo, completion: @escaping (Result<Void, AFError>) -> Void) {
        guard
            let idF = item.folderId,
            let id = item.id
            else { fatalError() }
        session
            .request("\(Current.backendUrl)/folders/\(idF)/items/\(id)", method: .delete)
            .validate()
            .response { response in
                completion(response.result.map { data -> Void in () })
        }
    }

    func getItems(inFolder idF: Int, completion: @escaping (Result<[Todo], AFError>) -> Void) {
        session
            .request("\(Current.backendUrl)/folders/\(idF)/items", method: .get)
            .validate()
            .responseDecodable(of: [Todo].self) { response in
                completion(response.result)
        }

    }

    func getItem(id: Int, idF: Int, completion: @escaping (Result<Todo, AFError>) -> Void) {
        session
            .request("\(Current.backendUrl)/folders/\(idF)/items/\(id)", method: .get)
            .validate()
            .responseDecodable(of: Todo.self) { response in
                completion(response.result)
        }
    }

}
