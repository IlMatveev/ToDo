//
//  FolderService.swift
//  ToDo
//
//  Created by Ilya Matveev on 16.01.2020.
//  Copyright © 2020 Ilya Matveev. All rights reserved.
//

import Foundation

protocol FolderObserver: class {
    func foldersChanged()
}

final class FolderService {
    static let shared: FolderService = .init()

    private init() {
    }

    private struct WeakBox {
        weak var value: FolderObserver?
    }

    private var observers: [WeakBox] = []

    func notify() {
        observers.forEach { observer in
            observer.value?.foldersChanged()
        }
    }

    func addObserver(observer: FolderObserver) {
        let currentObserver = WeakBox(value: observer)
        observers.append(currentObserver)
    }

    func removeObserver(observer: FolderObserver) {
        observers = observers.filter { $0.value !== observer }
    }

    func save(folder: Folder, completion: @escaping (Result<Void, Error>) -> Void) {
        if folder.id != nil {
            Current.repository.update(item: folder, in: .folders) { result in
                DispatchQueue.main.async {
                    completion(result.mapError { $0 }.map({ $0 }))
                    self.notify()
                }
            }
        } else {
            Current.repository.save(item: folder, to: .folders) { result in
                DispatchQueue.main.async {
                    completion(result.mapError { $0 }.map({ _ in () }))
                    self.notify()
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
                self.notify()
            }
        }
    }

}
