//
//  ToDoListItemsVM.swift
//  MyTasker
//
//  Created by Anushya Jeshtadi on 22/01/2025.
//
//import FirebaseAuth
//import FirebaseFirestore
//import Foundation
//class ToDoListItemsVM: ObservableObject {
////    @Published var showingNewItemView = false
//    init() {}
//    
//    func toggleIsDone(item: ToDoListitem) {
//        var itemCopy = item
//        itemCopy.setDone(!item.isDone)
//        
//        guard let uid = Auth.auth().currentUser?.uid else{
//            return
//        }
//        let db = Firestore.firestore()
//        db.collection("users")
//            .document(uid)
//            .collection("todos")
//            .document(itemCopy.id)
//            .setData(itemCopy.asDictionary())
//    }
////    func delete(id: String){}
//}

//working
//import FirebaseAuth
//import FirebaseFirestore
//import Foundation
//
//class ToDoListItemsVM: ObservableObject {
//    init() {}
//    
//    // Toggle the isDone status of a task
//    func toggleIsDone(item: ToDoListitem) {
//        var itemCopy = item
//        itemCopy.setDone(!item.isDone)
//        
//        guard let uid = Auth.auth().currentUser?.uid else {
//            return
//        }
//        
//        let db = Firestore.firestore()
//        db.collection("users")
//            .document(uid)
//            .collection("todos")
//            .document(itemCopy.id)
//            .setData(itemCopy.asDictionary())
//    }
//
//    // Function to update task details (title, description, dueDate, etc.)
//    func updateTask(item: ToDoListitem) {
//        guard let uid = Auth.auth().currentUser?.uid else {
//            return
//        }
//        
//        let db = Firestore.firestore()
//        db.collection("users")
//            .document(uid)
//            .collection("todos")
//            .document(item.id)
//            .setData(item.asDictionary()) { error in
//                if let error = error {
//                    print("Error updating task: \(error.localizedDescription)")
//                } else {
//                    print("Task updated successfully.")
//                }
//            }
//    }
//
//}



import FirebaseFirestore
import FirebaseAuth

class ToDoListItemsVM: ObservableObject {

    func updateTask(item: ToDoListitem) {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("User not authenticated")
            return
        }
        let db = Firestore.firestore()
        db.collection("users")
            .document(uid)
            .collection("todos")
            .document(item.id)
            .setData(item.asDictionary()) { error in
                if let error = error {
                    print("Error updating task: \(error.localizedDescription)")
                } else {
                    print("Task successfully updated.")
                }
            }
    }
    
    func toggleIsDone(item: ToDoListitem) {
        var itemCopy = item
        itemCopy.setDone(!item.isDone)
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        let db = Firestore.firestore()
        db.collection("users")
            .document(uid)
            .collection("todos")
            .document(itemCopy.id)
            .setData(itemCopy.asDictionary())
    }
}
