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
            guard let id = folder.id else { return }
            RestApiRepository.shared.update(from: .folders, id: id, item: folder) { result in
                DispatchQueue.main.async {
                    completion(result.mapError { $0 })
                }
            }
        } else {
            RestApiRepository.shared.save(from: .folders, item: folder) { result in
                DispatchQueue.main.async {
                    completion(result.mapError { $0 })
                }
            }
        }
    }

    func getFolder(id: Int, completion: @escaping (Result<Folder, Error>) -> Void) {
        RestApiRepository.shared.getOne(from: .folders, id: id) { result in
            DispatchQueue.main.async {
                completion(result.mapError { $0 })
            }
        }
    }

    func getFolders(_ completion: @escaping (Result<[Folder], Error>) -> Void) {
        RestApiRepository.shared.getAll(from: .folders) { result in
            DispatchQueue.main.async {
                completion(result.mapError { $0 })
            }
        }
    }

    func remove(id: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        RestApiRepository.shared.remove(from: .folders, id: id) { result in
            DispatchQueue.main.async {
                completion(result.mapError { $0 })
            }
        }
    }

}
