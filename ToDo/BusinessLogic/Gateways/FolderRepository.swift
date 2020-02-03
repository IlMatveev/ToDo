//
//  FolderRepository.swift
//  ToDo
//
//  Created by Ilya Matveev on 16.01.2020.
//  Copyright © 2020 Ilya Matveev. All rights reserved.
//

import Foundation
import Alamofire

final class FolderRepository {
    static let shared: FolderRepository = .init()

    let session: Session = .default

    private init() {
    }

    func save(toSave folder: Folder, completion: @escaping (Result<Folder, AFError>) -> Void) {
        session
            .request("\(Current.backendUrl)/folders", method: .post, parameters: folder)
            .validate()
            .responseDecodable(of: Folder.self) { response in
                completion(response.result)
            }
    }

    func update(toUpdate folder: Folder, completion: @escaping (Result<Folder, AFError>) -> Void) {
        guard let idF = folder.id else {
            fatalError("Folder not found")
        }
        session
            .request("\(Current.backendUrl)/folders/\(idF)", method: .put, parameters: folder)
            .validate()
            .responseDecodable(of: Folder.self) { response in
                completion(response.result)
            }

    }

    func remove(idF: Int, completion: @escaping (Result<Void, AFError>) -> Void) {
        session
            .request("\(Current.backendUrl)/folders/\(idF)", method: .delete)
            .validate()
            .response { response in
                completion(response.result.map { data -> Void in () })
            }
    }

    func getFolders(_ completion: @escaping (Result<[Folder], AFError>) -> Void) {
        session
            .request("\(Current.backendUrl)/folders", method: .get)
            .validate()
            .responseDecodable(of: [Folder].self) { response in
                completion(response.result)
            }
    }

    func getFolder(idF: Int, completion: @escaping (Result<Folder, AFError>) -> Void) {
        session
            .request("\(Current.backendUrl)/folders/\(idF)", method: .get)
            .validate()
            .responseDecodable(of: Folder.self) { response in
                completion(response.result)
            }
    }

}
