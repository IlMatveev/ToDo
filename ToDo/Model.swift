//
//  Model.swift
//  ToDo
//
//  Created by Ilya Matveev on 02.12.2019.
//  Copyright © 2019 Ilya Matveev. All rights reserved.
//

import Foundation

var ToDoItems : [String] = []

func addItem(nameItem: String) {
    ToDoItems.append(nameItem)
    saveData()
}

func removeItem(at index: Int) {
    ToDoItems.remove(at: index)
    saveData()
}

func saveData() {
    
}

func loadData() {
    
}
