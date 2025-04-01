//
//  ToListEditVM.swift
//  MyTasker
//
//  Created by Anushya Jeshtadi on 22/01/2025.
//
import FirebaseFirestore
import Foundation
class AfterLoginViewVM: ObservableObject{
    
    @Published var showingNewItemView = false
    private let userId:String
    
    init(userId: String){
        self.userId = userId
    }
    
//        func delete(id: String){
//            //reference to databae
//            let db = Firestore.firestore()
//            db.collection("users")
//                .document(userId)
//                .collection("todos")
//                .document(id)
//                .delete()
//        }
//    
//        func delete(id: String) {
//            let db = Firestore.firestore()
//            db.collection("users")
//                .document(userId)
//                .collection("todos")
//                .document(id)
//                .updateData(["isDeleted": true]) { error in
//                    if let error = error {
//                        print("Error updating document: \(error.localizedDescription)")
//                    } else {
//                        print("Task marked as deleted.")
//                    }
//                }
//        }
    
    
    func delete(id: String) {
        let db = Firestore.firestore()
        
        let taskRef = db.collection("users")
            .document(userId)
            .collection("recently_deleted")
            .document(id)
        
        taskRef.getDocument { (document, error) in
            if let error = error {
                print("Error fetching document: \(error.localizedDescription)")
                return
            }
            
            guard let document = document, document.exists else {
                print("Document does not exist.")
                return
            }
            
            let originalTaskRef = db.collection("users")
                .document(self.userId)
                .collection("todos")
                .document(id)
            
            originalTaskRef.updateData(["isDeleted": true]) { error in
                if let error = error {
                    print("Error updating 'isDeleted' field: \(error.localizedDescription)")
                } else {
                    print("Task 'isDeleted' updated to true.")
                }
            }
        }
    }
}

