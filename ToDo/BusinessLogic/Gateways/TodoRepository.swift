//
//  TodoRepository.swift
//  ToDo
//
//  Created by Ilya Matveev on 07.01.2020.
//  Copyright © 2020 Ilya Matveev. All rights reserved.
//

import Foundation

enum APIError: Error {
    case responseProblem
    case decodingProblem
    case encodingProblem
}

final class TodoRepository {
    static let shared: TodoRepository = .init()

    private init() {
    }

    func save(toSave item: Todo, completion: @escaping (Result<Void, APIError>) -> Void) {
        guard
            let idF = item.from,
            let resourceURL = URL(string: "http://localhost:3000/folders/\(idF)/items/")
        else { return }
        var urlRequest = URLRequest(url: resourceURL)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = try? JSONEncoder().encode(item)

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { _, response, _ in
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200
            else {
                completion(.failure(.responseProblem))
                return
            }
            completion(.success(()))
        }
        dataTask.resume()
    }

    func update(toUpdate item: Todo, completion: @escaping (Result<Void, APIError>) -> Void) {
        guard
            let idF = item.from,
            let id = item.id,
            let resourceURL = URL(string: "http://localhost:3000/folders/\(idF)/items/\(id)")
            else { return }
        var urlRequest = URLRequest(url: resourceURL)
        urlRequest.httpMethod = "PUT"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = try? JSONEncoder().encode(item)

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { _, response, _ in
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200
            else {
                completion(.failure(.responseProblem))
                return
            }
            completion(.success(()))
        }
        dataTask.resume()
    }

    func remove(item: Todo, completion: @escaping (Result<Void, APIError>) -> Void) {
        guard
            let idF = item.from,
            let id = item.id,
            let resourceURL = URL(string: "http://localhost:3000/folders/\(idF)/items/\(id)") else { fatalError() }
        var urlRequest = URLRequest(url: resourceURL)
        urlRequest.httpMethod = "DELETE"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { _, response, _ in
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200
            else {
                completion(.failure(.responseProblem))
                return
            }
            completion(.success(()))
        }
        dataTask.resume()
    }

    func getItems(inFolder idF: Int, completion: @escaping (Result<[Todo], APIError>) -> Void) {
        guard let resourceURL = URL(string: "http://localhost:3000/folders/\(idF)/items/") else { fatalError() }

        var urlRequest = URLRequest(url: resourceURL)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, _ in
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200,
                let jsonData = data
                else {
                    completion(.failure(.responseProblem))
                    return
            }
            do {
                let todoData = try JSONDecoder().decode([Todo].self, from: jsonData)
                completion(.success(todoData))
            } catch {
                dump(error)
                completion(.failure(.decodingProblem))
            }
        }
        dataTask.resume()
    }

    func getItem(item: Todo, completion: @escaping (Result<Todo, APIError>) -> Void) {
        guard
            let idF = item.from,
            let id = item.id,
            let resourceURL = URL(string: "http://localhost:3000/folders/\(idF)/items/\(id)")
        else { return }
        var urlRequest = URLRequest(url: resourceURL)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, _ in
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200,
                let jsonData = data
                else {
                    completion(.failure(.responseProblem))
                    return
            }
            do {
                let todoData = try JSONDecoder().decode(Todo.self, from: jsonData)
                completion(.success(todoData))
            } catch {
                completion(.failure(.decodingProblem))
            }
        }
        dataTask.resume()
    }

}
