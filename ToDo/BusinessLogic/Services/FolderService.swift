//
//  FolderService.swift
//  ToDo
//
//  Created by Ilya Matveev on 16.01.2020.
//  Copyright © 2020 Ilya Matveev. All rights reserved.
//

import Foundation

final class FolderService {
    static let shared: FolderService = .init()

    private init() {
    }
    
    func save(folder: Folder, completion: @escaping (Result<Void, Error>) -> Void) {
        if folder.id != nil {
            Current.repository.update(item: folder, in: .folders) { result in
                DispatchQueue.main.async {
                    completion(result.mapError { $0 }.map({ $0 }))
                }
            }
        } else {
            Current.repository.save(item: folder, to: .folders) { result in
                DispatchQueue.main.async {
                    completion(result.mapError { $0 }.map { _ in () })
                }
            }
        }
    }

    func getFolder(id: Folder.ID, completion: @escaping (Result<Folder, Error>) -> Void) {
        Current.repository.getOne(id: id, from: .folders) { result in
            DispatchQueue.main.async {
                completion(result.mapError { $0 })
            }
        }
    }

    func getFolders(_ completion: @escaping (Result<[Folder], Error>) -> Void) {
        Current.repository.getAll(from: .folders) { result in
            DispatchQueue.main.async {
                completion(result.mapError { $0 })
            }
        }
    }

    func remove(id: Folder.ID, completion: @escaping (Result<Void, Error>) -> Void) {
        Current.repository.remove(id: id, from: .folders) { result in
            DispatchQueue.main.async {
                completion(result.mapError { $0 })
            }
        }
    }

}
