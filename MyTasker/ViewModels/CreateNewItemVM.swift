//
//  CreateNewItemVM.swift
//  MyTasker
//
//  Created by Anushya Jeshtadi on 22/01/2025.



//current using code
//import FirebaseAuth
//import FirebaseFirestore
//import Foundation
//import SwiftUI
//
//class CreateNewItemVM: ObservableObject {
//    @Published var title = ""
//    @Published var description = ""
//    @Published var dueDate = Date()
//    @Published var duration: TimeInterval = 0
//    @Published var isMinutesSelected: Bool = true
//    @Published var selectedColor: String = "Default"
//    @Published var repeatInterval: TimeInterval? = nil
//    @Published var notifyBefore: TimeInterval? = nil
////    @Published var additionalInfo: String = ""
//    @Published var showAlert = false
//    @Published var showSuccessAlert = false
//    @Published var tasks: [ToDoListitem] = []
//    
//    private let db = Firestore.firestore()
//
//    init() {
//        fetchTasks()
//    }
//
////    func fetchTasks() {
////        guard let uId = Auth.auth().currentUser?.uid else { return }
////
////        db.collection("users")
////            .document(uId)
////            .collection("todos")
////            .getDocuments { [weak self] snapshot, error in
////                guard let documents = snapshot?.documents, error == nil else {
////                    print("Failed to fetch tasks: \(error?.localizedDescription ?? "Unknown error")")
////                    return
////                }
////
////                self?.tasks = documents.compactMap { doc in
////                    guard let data = doc.data() as? [String: Any] else { return nil }
////                    return ToDoListitem(
////                        id: data["id"] as? String ?? UUID().uuidString,
////                        title: data["title"] as? String ?? "",
////                        description: data["description"] as? String ?? "",
////                        dueDate: data["dueDate"] as? TimeInterval ?? 0,
////                        createDate: data["createDate"] as? TimeInterval ?? 0,
////                        duration: data["duration"] as? TimeInterval ?? 0,
////                        isDone: data["isDone"] as? Bool ?? false,
////                        color: data["color"] as? String ?? "",
////                        repeatInterval: data["repeatInterval"] as? TimeInterval != nil ? String(data["repeatInterval"] as! TimeInterval) : nil
//////                        repeatInterval: data["repeatInterval"] as? TimeInterval ?? 0,
//////                        notifyBefore: data["notifyBefore"] as? TimeInterval ?? 0
//////                        notifyBefore: data["notifyBefore"] as? TimeInterval != nil ? String(data["notifyBefore"] as! TimeInterval) : nil
////                        
////                    )
////                }
////            }
////    }
//
//    
//    func fetchTasks() {
//        guard let uId = Auth.auth().currentUser?.uid else { return }
//
//        db.collection("users")
//            .document(uId)
//            .collection("todos")
//            .getDocuments { [weak self] snapshot, error in
//                guard let documents = snapshot?.documents, error == nil else {
//                    print("Failed to fetch tasks: \(error?.localizedDescription ?? "Unknown error")")
//                    return
//                }
//
//                self?.tasks = documents.compactMap { doc in
//                    let data = doc.data()  
//
//                    return ToDoListitem(
//                        id: data["id"] as? String ?? UUID().uuidString,
//                        title: data["title"] as? String ?? "",
//                        description: data["description"] as? String ?? "",
//                        dueDate: data["dueDate"] as? TimeInterval ?? 0,
//                        createDate: data["createDate"] as? TimeInterval ?? 0,
//                        duration: data["duration"] as? TimeInterval,
//                        isDone: data["isDone"] as? Bool ?? false,
//                        color: data["color"] as? String ?? "Default",
//                        repeatInterval: data["repeatInterval"] as? TimeInterval,
//                        notifyBefore: data["notifyBefore"] as? TimeInterval
//                    )
//                }
//            }
//    }
//
//    
//
//    func save() {
//        guard canSave else { return }
//        guard let uId = Auth.auth().currentUser?.uid else { return }
//
//        let newId = UUID().uuidString
//        let newItem = ToDoListitem(
//            id: newId,
//            title: title,
//            description: description,
//            dueDate: dueDate.timeIntervalSince1970,
//            createDate: Date().timeIntervalSince1970,
//            duration: duration,
//            isDone: false,
//            color: selectedColor,
//            repeatInterval: repeatInterval,
//            notifyBefore: notifyBefore
//            
//        )
//
//        db.collection("users")
//            .document(uId)
//            .collection("todos")
//            .document(newId)
//            .setData(newItem.asDictionary()) { [weak self] error in
//                if error == nil {
//                    DispatchQueue.main.async {
//                        self?.tasks.append(newItem)
//                        self?.resetFields()
//                        self?.showSuccessAlert = true
//                        
//                        // Schedule Notification
//                        NotificationManager.shared.scheduleNotification(for: newItem)
//                    }
//                } else {
//                    print("Failed to save task: \(String(describing: error?.localizedDescription))")
//                }
//            }
//    }
//
//    var canSave: Bool {
//        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else { return false }
//        guard dueDate >= Date().addingTimeInterval(-86400) else { return false }
//        return true
//    }
//    func getTaskColor() -> Color {
//            switch selectedColor {
//            case "Red": return .red
//            case "Blue": return .blue
//            case "Green": return .green
//            case "Yellow": return .yellow
//            default: return .gray // Default color if no match
//            }
//        }
//
//    private func resetFields() {
//        title = ""
//        description = ""
//        dueDate = Date()
//        duration = 0
//        selectedColor = "Default"
//        repeatInterval = nil
//        notifyBefore = nil
////        additionalInfo = ""
//    }
//}
//
//

























//notification
//import Foundation
//import UserNotifications
//
//class NotificationManager {
//    static let shared = NotificationManager()
//    
//    private init() {}
//    
//    /// Request notification permissions from the user
//    func requestPermission() {
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
//            if let error = error {
//                print("Error requesting permission: \(error.localizedDescription)")
//            } else {
//                print("Notification permission granted: \(granted)")
//            }
//        }
//    }
//    
//    /// Schedule a notification for a task
//    func scheduleNotification(for task: ToDoListItem) {
//        guard let notifyBefore = task.notifyBefore else { return } // If no notification time, exit
//        
//        let notificationTime = task.dueDate - notifyBefore  // Calculate notification time
//        
//        // Prevent scheduling notifications in the past
//        if notificationTime < Date().timeIntervalSince1970 { return }
//        
//        let content = UNMutableNotificationContent()
//        content.title = "Task Reminder"
//        content.body = "Don't forget: \(task.title)"
//        content.sound = .default
//        
//        let triggerDate = Date(timeIntervalSince1970: notificationTime)
//        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: triggerDate), repeats: false)
//
//        let request = UNNotificationRequest(identifier: task.id, content: content, trigger: trigger)
//
//        UNUserNotificationCenter.current().add(request) { error in
//            if let error = error {
//                print("Error scheduling notification: \(error.localizedDescription)")
//            } else {
//                print("Notification scheduled for \(task.title) at \(triggerDate)")
//            }
//        }
//    }
//    
//    /// Remove a scheduled notification (if task is deleted or updated)
//    func removeNotification(for taskId: String) {
//        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [taskId])
//        print("Removed notification for task ID: \(taskId)")
//    }
//}




import FirebaseAuth
import FirebaseFirestore
import Foundation
import SwiftUI

class CreateNewItemVM: ObservableObject {
    @Published var title = ""
    @Published var description = ""
    @Published var dueDate = Date()
    @Published var duration: TimeInterval = 0
    @Published var isMinutesSelected: Bool = true
    @Published var selectedColor: String = "Default"
    @Published var repeatInterval: TimeInterval? = nil
    @Published var notifyBefore: TimeInterval? = nil
    @Published var showAlert = false
    @Published var showSuccessAlert = false
    @Published var tasks: [ToDoListitem] = []
    
    private let db = Firestore.firestore()

    init() {
        fetchTasks()
    }

    func fetchTasks() {
        guard let uId = Auth.auth().currentUser?.uid else { return }

        db.collection("users")
            .document(uId)
            .collection("todos")
            .getDocuments { [weak self] snapshot, error in
                guard let documents = snapshot?.documents, error == nil else {
                    print("Failed to fetch tasks: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }

                self?.tasks = documents.compactMap { doc in
                    let data = doc.data()

                    return ToDoListitem(
                        id: data["id"] as? String ?? UUID().uuidString,
                        title: data["title"] as? String ?? "",
                        description: data["description"] as? String ?? "",
                        dueDate: data["dueDate"] as? TimeInterval ?? 0,
                        createDate: data["createDate"] as? TimeInterval ?? 0,
                        duration: data["duration"] as? TimeInterval,
                        isDone: data["isDone"] as? Bool ?? false,
                        color: data["color"] as? String ?? "Default",
                        repeatInterval: data["repeatInterval"] as? TimeInterval,
                        notifyBefore: data["notifyBefore"] as? TimeInterval
                    )
                }
            }
    }

    func save() {
        guard canSave else { return }
        guard let uId = Auth.auth().currentUser?.uid else { return }

        let newId = UUID().uuidString
        let newItem = ToDoListitem(
            id: newId,
            title: title,
            description: description,
            dueDate: dueDate.timeIntervalSince1970,
            createDate: Date().timeIntervalSince1970,
            duration: duration,
            isDone: false,
            color: selectedColor,
            repeatInterval: repeatInterval,
            notifyBefore: notifyBefore
        )

        db.collection("users")
            .document(uId)
            .collection("todos")
            .document(newId)
            .setData(newItem.asDictionary()) { [weak self] error in
                if error == nil {
                    DispatchQueue.main.async {
                        self?.tasks.append(newItem)
                        self?.resetFields()
                        self?.showSuccessAlert = true
                        
                        // Schedule Notification
                        NotificationManager.shared.scheduleNotification(for: newItem)
                    }
                } else {
                    print("Failed to save task: \(String(describing: error?.localizedDescription))")
                }
            }
    }

    var canSave: Bool {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else { return false }
        guard dueDate >= Date().addingTimeInterval(-86400) else { return false }
        return true
    }

    func getTaskColor() -> Color {
        switch selectedColor {
        case "Red": return .red
        case "Blue": return .blue
        case "Green": return .green
        case "Yellow": return .yellow
        default: return .gray // Default color if no match
        }
    }

    private func resetFields() {
        title = ""
        description = ""
        dueDate = Date()
        duration = 0
        selectedColor = "Default"
        repeatInterval = nil
        notifyBefore = nil
    }
}
