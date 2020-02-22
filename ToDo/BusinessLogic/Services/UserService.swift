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

    var currentUser: User?

    private var users: [User] = UserDefaults.standard.array(forKey: "UsersKey") as? [User] ?? []

    private init() {
    }

    func addUser(user: User) {
        users.append(user)
        UserDefaults.standard.set(users, forKey: "UsersKey")
        UserDefaults.standard.synchronize()
    }

    func updateUser(user: User) {
        guard let index = users.firstIndex(where: {$0.login == user.login}) else {
            fatalError("User not found")
        }
        users.insert(user, at: index)
        UserDefaults.standard.set(users, forKey: "UsersKey")
        UserDefaults.standard.synchronize()
    }

    func checkUser(user: User) -> Bool {
        return users.contains { (user.login == $0.login) && (user.password == $0.password) }
    }

    func authCheckUser() -> User? {
        return users.first {$0.isLogin == true}
    }

}
