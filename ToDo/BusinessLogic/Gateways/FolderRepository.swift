//
//  FolderRepository.swift
//  ToDo
//
//  Created by Ilya Matveev on 16.01.2020.
//  Copyright © 2020 Ilya Matveev. All rights reserved.
//

import Foundation

final class FolderRepository {
    static let shared: FolderRepository = .init()

    private init() {
    }

    func save(toSave folder: Folder, completion: @escaping (Result<Void, APIError>) -> Void) {
        guard let resourceURL = URL(string: "http://localhost:3000/folders") else { return }
        var urlRequest = URLRequest(url: resourceURL)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = try? JSONEncoder().encode(folder)

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

    func update(toUpdate folder: Folder, completion: @escaping (Result<Void, APIError>) -> Void) {
        guard
            let id = folder.id,
            let resourceURL = URL(string: "http://localhost:3000/folders/\(id)")
            else { return }
        var urlRequest = URLRequest(url: resourceURL)
        urlRequest.httpMethod = "PUT"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = try? JSONEncoder().encode(folder)

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

    func remove(id: Int, completion: @escaping (Result<Void, APIError>) -> Void) {
        guard let resourceURL = URL(string: "http://localhost:3000/folders/\(id)") else { fatalError() }
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

    func getFolders(_ completion: @escaping (Result<[Folder], APIError>) -> Void) {
        guard let resourceURL = URL(string: "http://localhost:3000/folders/") else { fatalError() }

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
                let folderData = try JSONDecoder().decode([Folder].self, from: jsonData)
                completion(.success(folderData))
            } catch {
                dump(error)
                completion(.failure(.decodingProblem))
            }
        }
        dataTask.resume()
    }

    func getFolder(id: Int, completion: @escaping (Result<Folder, APIError>) -> Void) {

        if let resourceURL = URL(string: "http://localhost:3000/folders/\(id)") {
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
                    let folderData = try JSONDecoder().decode(Folder.self, from: jsonData)
                    completion(.success(folderData))
                } catch {
                    completion(.failure(.decodingProblem))
                }
            }
            dataTask.resume()
        } else { return }
    }

}
