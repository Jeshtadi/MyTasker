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
    
    func delete(id: String){
        //reference to databae
        let db = Firestore.firestore()
        db.collection("users")
            .document(userId)
            .collection("todos")
            .document(id)
            .delete()
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
