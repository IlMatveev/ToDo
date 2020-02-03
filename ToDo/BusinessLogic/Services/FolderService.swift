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

    var folders: [Folder] = []

    func save(folder: Folder, completion: @escaping (Result<Folder, Error>) -> Void) {
        if folder.id != nil {
            FolderRepository.shared.update(toUpdate: folder) { result in
                DispatchQueue.main.async {
                    completion(result.mapError { $0 })
                }
            }
        } else {
            FolderRepository.shared.save(toSave: folder) { result in
                DispatchQueue.main.async {
                    completion(result.mapError { $0 })
                }
            }
        }
    }

    func getFolder(id: Int, completion: @escaping (Result<Folder, Error>) -> Void) {
        FolderRepository.shared.getFolder(idF: id) { result in
            DispatchQueue.main.async {
                completion(result.mapError { $0 })
            }
        }
    }

    func getFolders(_ completion: @escaping (Result<[Folder], Error>) -> Void) {
        FolderRepository.shared.getFolders { result in
            DispatchQueue.main.async {
                completion(result.mapError { $0 })
            }
        }
    }

    func remove(id: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        FolderRepository.shared.remove(idF: id) { result in
            DispatchQueue.main.async {
                completion(result.mapError { $0 })
            }
        }
    }

}
