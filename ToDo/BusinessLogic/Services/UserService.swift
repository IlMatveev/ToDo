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

    var currentUser: Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: "UserKey")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.bool(forKey: "UserKey")
        }
    }

    private init() {
    }

    func signIn(login: String, password: String, completion: @escaping (Result<User?, Error>) -> Void) {
        Current.repository.getUser(login: login, password: password) { result in
            DispatchQueue.main.async {
                completion(result.mapError { $0 })
                let currentUser: User? = try? result.get()
                if currentUser != nil {
                    self.currentUser = true
                }
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
        currentUser = false
    }

}
