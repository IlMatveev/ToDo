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
            Current.repository.update(from: .folders, item: folder) { result in
                DispatchQueue.main.async {
                    completion(result.mapError { $0 })
                }
            }
        } else {
            Current.repository.save(from: .folders, item: folder) { result in
                DispatchQueue.main.async {
                    completion(result.mapError { $0 }.map { _ in () })
                }
            }
        }
    }

    func getFolder(id: Folder.ID, completion: @escaping (Result<Folder, Error>) -> Void) {
        Current.repository.getOne(from: .folders, id: id) { result in
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
        Current.repository.remove(from: .folders, id: id) { result in
            DispatchQueue.main.async {
                completion(result.mapError { $0 })
            }
        }
    }

}
