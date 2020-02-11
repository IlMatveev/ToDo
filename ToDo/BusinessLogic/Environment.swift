//
//  Environment.swift
//  ToDo
//
//  Created by Ilya Matveev on 31.01.2020.
//  Copyright © 2020 Ilya Matveev. All rights reserved.
//

import Foundation

struct Environment {
    var date: () -> Date = Date.init
    var repository: Repository = RestApiRepository(backendUrl: "http://localhost:3000/")
}

// swiftlint:disable variable_name
var Current: Environment = .init()
// swiftlint:enable variable_name

extension Environment {
    static let mock: Environment = .init(
        date: { Date.init(timeIntervalSince1970: 25254353345) },
        repository: InMemoryRepository()
    )
}
