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

    private var users: [User] = []

    private init() {
    }

    func addUser (user: User) {
        users.append(user)
        print("YES")
    }

    func checkUser (user: User) -> Bool {
        var index = false

        for currentUser in users where (user.login == currentUser.login) && (user.password == currentUser.password) {
            index = true
        }
        if index == true {
            return true
              } else {
            return false
              }
    }

}
