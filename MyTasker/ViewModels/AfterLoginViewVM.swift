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
    
//    func delete(id: String){
//        //reference to databae
//        let db = Firestore.firestore()
//        db.collection("users")
//            .document(userId)
//            .collection("todos")
//            .document(id)
//            .delete()
//    }
    
//    func delete(id: String) {
//        let db = Firestore.firestore()
//        db.collection("users")
//            .document(userId)
//            .collection("todos")
//            .document(id)
//            .updateData(["isDeleted": true]) { error in
//                if let error = error {
//                    print("Error updating document: \(error.localizedDescription)")
//                } else {
//                    print("Task marked as deleted.")
//                }
//            }
//    }
    
    
    func delete(id: String) {
        let db = Firestore.firestore()

        // Reference to the task document
        let taskRef = db.collection("users")
            .document(userId)
            .collection("todos")
            .document(id)

        // Get the task data before updating (in case you need to preserve it for the "recently deleted" section)
        taskRef.getDocument { (document, error) in
            if let error = error {
                print("Error fetching document: \(error.localizedDescription)")
                return
            }

            guard let document = document, document.exists else {
                print("Document does not exist.")
                return
            }

            // Move the task to the "recently deleted" collection
            db.collection("users")
                .document(self.userId)
                .collection("recently_deleted")
                .document(id)
                .setData(document.data()!) { error in
                    if let error = error {
                        print("Error moving document to 'recently_deleted': \(error.localizedDescription)")
                    } else {
                        print("Task successfully moved to 'recently_deleted'.")
                    }
                }

            // Now mark the task as deleted in the original collection
            taskRef.updateData(["isDeleted": true]) { error in
                if let error = error {
                    print("Error updating document: \(error.localizedDescription)")
                } else {
                    print("Task marked as deleted.")
                }
            }
        }
    }


}


//class AfterLoginViewVM: ObservableObject {
//    @Published var userName: String = "User" // Replace with actual logic to fetch user name
//    @Published var taskCount: Int = 0 // Update dynamically
//    @Published var searchText: String = ""
//    @Published var todaysTasks: [TaskModel] = [] // Replace with your logic to fetch tasks
//
//    func filterTasks(by status: TaskStatus) {
//        // Implement filtering logic
//    }
//
//    func selectTask(_ task: TaskModel) {
//        // Implement task selection logic
//    }
//
//    func showProfile() {
//        // Navigate to profile view
//    }
//}
