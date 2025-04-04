//
//  ToDoListItemsVM.swift
//  MyTasker
//
//  Created by Anushya Jeshtadi on 22/01/2025.
//



//working right now
import FirebaseAuth
import FirebaseFirestore
import Foundation

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
