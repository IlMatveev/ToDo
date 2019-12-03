//
//  Model.swift
//  ToDo
//
//  Created by Ilya Matveev on 02.12.2019.
//  Copyright © 2019 Ilya Matveev. All rights reserved.
//

import Foundation

<<<<<<< Updated upstream
var ToDoItems : [String] = []
=======
var ToDoItems : [[String: Any]] = []
>>>>>>> Stashed changes

func addItem(nameItem: String) {
    ToDoItems.append(nameItem)
    saveData()
}

func removeItem(at index: Int) {
    ToDoItems.remove(at: index)
    saveData()
}

func changeMark(at item: Int) -> Bool {
    ToDoItems[item]["isCompleted"] = !(ToDoItems[item]["isCompleted"] as! Bool)
    saveData()
    return (ToDoItems[item]["isCompleted"] as! Bool)
}

func saveData() {
    
}

func loadData() {
    
}
