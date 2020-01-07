//
//  APIRequest.swift
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

struct APIRequest {
    let resourceURL: URL

    init(endpoint: String) {
        let resourceString = "http://localhost:3000/items/\(endpoint)"
        guard let resourceURL = URL(string: resourceString) else { fatalError() }

        self.resourceURL = resourceURL
    }

    func save(_ toSave: cTodo, completion: @escaping(Result<cTodo, APIError>) -> Void) {
        do {
            var urlRequest = URLRequest(url: resourceURL)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(toSave)

            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, _ in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let jsonData = data else {
                    completion(.failure(.responseProblem))
                    return
                }

                do {
                    let todoData = try JSONDecoder().decode(cTodo.self, from: jsonData)
                    completion(.success(todoData))
                } catch {
                    completion(.failure(.decodingProblem))
                }
            }
            dataTask.resume()
        } catch {
            completion(.failure(.encodingProblem))
        }
    }

}
