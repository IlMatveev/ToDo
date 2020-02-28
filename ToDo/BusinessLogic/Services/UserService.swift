//
//  UserService.swift
//  ToDo
//
//  Created by Ilya Matveev on 22.12.2019.
//  Copyright © 2019 Ilya Matveev. All rights reserved.
//

import Foundation

final class UserService {
    static let shared: UserService = .init()

    private(set) var currentUser: User?

    private init() {
    }

    func signIn(login: String, password: String, completion: @escaping (Result<User?, Error>) -> Void) {
        Current.repository.getUser(login: login, password: password) { result in
            DispatchQueue.main.async {
                completion(result.mapError { $0 })
                self.currentUser = try? result.get()
//                self.updateUserDefaults()
            }
        }
    }

    func signUp(user: User, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Current.repository.save(item: user, to: .users) { result in
            DispatchQueue.main.async {
                completion(result.mapError { $0 })
            }
        }
    }

    func logOut(_ completion: @escaping (Result<Void, Error>) -> Void) {
        currentUser = nil
    }

    func updateUserDefaults() {
        UserDefaults.standard.set(currentUser, forKey: "UserKey")
    }

}
