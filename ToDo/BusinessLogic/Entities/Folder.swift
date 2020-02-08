//
//  Folder.swift
//  ToDo
//
//  Created by Ilya Matveev on 16.01.2020.
//  Copyright © 2020 Ilya Matveev. All rights reserved.
//

import Foundation

struct Folder: Codable, Entity {
    var id: ID?
    var name: String = ""
}

struct EntityCollection<E> {
    let path: String
}

struct Identifier<E>: RawRepresentable, Codable, Equatable {
    let rawValue: Int
}

extension EntityCollection where E == Folder {
    static let folders: EntityCollection = .init(path: "folders")
}

protocol Entity: Codable {
    typealias Collection = EntityCollection<Self>
    typealias ID = Identifier<Self>

    var id: ID? { get set }
}
