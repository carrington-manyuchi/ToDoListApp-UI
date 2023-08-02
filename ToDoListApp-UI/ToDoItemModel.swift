//
//  ToDoItemModel.swift
//  ToDoListApp-UI
//
//  Created by DA MAC M1 157 on 2023/08/01.
//

import Foundation

struct ToDoItemModel {
    
    var name: String
    
    var details: String
    
    var completionDate: Date
    
    var startDate: Date
    
    var  isComplete: Bool
    
    
    init(name: String, details: String, completionDate: Date, startDate: Date, isComplete: Bool) {
        self.name = name
        self.details = details
        self.completionDate = completionDate
        self.startDate = Date()
        self.isComplete = false
    }
}
