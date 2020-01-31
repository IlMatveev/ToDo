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
    var backendUrl: String = "http://localhost:3000"
}

var Current: Environment = .init()

extension Environment {
    static let mock: Environment = .init(
        date: { Date.init(timeIntervalSince1970: 25254353345) }
    )
}
