//
//  InMemoryRepository.swift
//  ToDo
//
//  Created by Ilya Matveev on 06.02.2020.
//  Copyright © 2020 Ilya Matveev. All rights reserved.
//

import Foundation

final class InMemoryRepository {
    var items: [Todo] = []
    var folders: [Folder] = []

    func add<T: Entity>(collection: T.Collection, item: T) {
        
    }

}
