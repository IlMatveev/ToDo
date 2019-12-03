//
//  Model.swift
//  ToDo
//
//  Created by Ilya Matveev on 02.12.2019.
//  Copyright © 2019 Ilya Matveev. All rights reserved.
//

import Foundation

var ToDoItems : [[String: Any]] {
    set {
        UserDefaults.standard.set(newValue, forKey: "ToDoKey")
        UserDefaults.standard.synchronize()
    }
    get {
        if let array = UserDefaults.standard.array(forKey: "ToDoKey") as? [[String: Any]] {
              return array
          }
          else {
              return []
          }
    }
}

func addItem(nameItem: String, isComplited: Bool = false) {
    ToDoItems.append(["Name": nameItem, "isComplited": isComplited])
}

func changeMark(at item: Int) -> Bool {
    ToDoItems[item]["isComplited"] = !(ToDoItems[item]["isComplited"] as! Bool)
    return ToDoItems[item]["isComplited"] as! Bool
}

func removeItem(at index: Int) {
    ToDoItems.remove(at: index)
}
