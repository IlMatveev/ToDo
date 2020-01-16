//
//  Folder.swift
//  ToDo
//
//  Created by Ilya Matveev on 16.01.2020.
//  Copyright © 2020 Ilya Matveev. All rights reserved.
//

import Foundation

struct Folder: Codable {
    var id: Int?
    var name: String = ""
    var items: [Todo]?
}
