//
//  User.swift
//  ToDo
//
//  Created by Ilya Matveev on 23.12.2019.
//  Copyright © 2019 Ilya Matveev. All rights reserved.
//

import Foundation

struct User: Codable, Entity {
    var id: ID?
    var login: String
    var password: String
}

extension EntityCollection where E == User {
    static var users: EntityCollection<User> {
        return .init(path: "users/")
    }
}
