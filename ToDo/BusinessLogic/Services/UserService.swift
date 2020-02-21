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

    private var users: [User] = [
        User(login: "1", password: "1")
    ]

    private init() {
    }

    func addUser(user: User) {
        users.append(user)
    }

    func checkUser(user: User) -> Bool {
      return users.contains { (user.login == $0.login) && (user.password == $0.password) }
    }

}
