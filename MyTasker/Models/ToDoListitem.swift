//
//  ToDoListItem.swift
//  MyTasker
//
//  Created by Anushya Jeshtadi on 22/01/2025.
//

//import Foundation
//struct ToDoListitem: Codable, Identifiable{
//    let id: String
//    let title: String
//    let dueDate: TimeInterval
//    let createDate: TimeInterval
//    var isDone:  Bool
//    
//    mutating func setDone(_ state: Bool){
//        isDone = state
//    }
//}

import Foundation

struct ToDoListitem: Codable, Identifiable {
    
    var id: String
    var title: String
    var description: String?
    var dueDate: TimeInterval
    var createDate: TimeInterval
    var duration: TimeInterval?
    var isDone: Bool
    var color: String?
    var repeatInterval: TimeInterval?
    var notifyBefore: TimeInterval?
    var isDeleted: Bool = false
    
    mutating func setDone(_ state: Bool) {
        isDone = state
    }
    
}




//    mutating func setDone(_ state: Bool) {
//        isDone = state
//    }
//}

//NEED TO ADD DONE, IN PROGRESS,TODOS DB
//MAYBE NEED TO DO PAGES
//DESCRIPTION OF MOODLE NEEDS FIXING
//EDIT TASK NEEDS NOTIFICATION
//NOTIFACTIONS WORKS (HALF)
//CALENDER VIEW DESNGING
//implemetn accessibility features

