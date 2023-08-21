//
//  ToDoItem.swift
//  ToDoList2
//
//  Created by Scholar on 8/21/23.
//

import Foundation

class ToDoItem : Identifiable {
    
    var title : String
    var isImportant : Bool
    // unique id for each object
    var id = UUID()
    
    init(title : String, isImportant : Bool = false) {
        self.title = title
        self.isImportant = isImportant
    }
    
}
