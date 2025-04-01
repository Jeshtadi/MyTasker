////
////  NotificationManager.swift
////  MyTasker
////
////  Created by Anushya Jeshtadi on 10/02/2025.
////
//WORKING
//import Foundation
//import UserNotifications
//
//class NotificationManager {
//    static let shared = NotificationManager()
//    
//    private init() {}
//    
//    func requestPermission() {
//        let notificationCenter = UNUserNotificationCenter.current()
//        notificationCenter.getNotificationSettings { settings in
//            switch settings.authorizationStatus {
//            case .authorized:
//                self.dispatchNotification()
//            case .denied:
//                return
//            case .notDetermined:
//                notificationCenter.requestAuthorization(options:  [.alert, .sound]) { didAllow, error in
//                    if didAllow {
//                        self.dispatchNotification()
//                    }
//                }
//            default:
//                return
//            }
//        }
//    }
//    
//    func dispatchNotification() {
//        let title = "Time to work"
//        let body = "Don't be last!"
//        let hour = 16
//        let minute = 39
//        
//        let notificationCenter = UNUserNotificationCenter.current()
//        let content = UNMutableNotificationContent()
//        content.title = title
//        content.body = body
//        content.sound = .default
//        
//        let calendar = Calendar.current
//        var dateComponents = DateComponents(calendar: calendar, timeZone: TimeZone.current)
//        dateComponents.hour = hour
//        dateComponents.minute = minute
//        
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
//        let request = UNNotificationRequest(identifier: "workReminder", content: content, trigger: trigger)
//        
//        notificationCenter.add(request) { error in
//            if let error = error {
//                print("Error scheduling notification: \(error.localizedDescription)")
//            }
//        }
//    }
//    
//    /// Schedule a notification for a task
//    func scheduleNotification(for task: ToDoListitem) {
//        guard let notifyBefore = task.notifyBefore else { return }
//
//        let notificationTime = task.dueDate - notifyBefore
//        if notificationTime < Date().timeIntervalSince1970 {
//            print("Notification time is in the past. Skipping.")
//            return
//        }
//
//        let content = UNMutableNotificationContent()
//        content.title = "Task Reminder"
//        content.body = "Your task is due: \(task.title)"
//        content.sound = .default
//
//        let triggerDate = Date(timeIntervalSince1970: notificationTime)
//        let trigger = UNCalendarNotificationTrigger(
//            dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: triggerDate),
//            repeats: false
//        )
//
//        let request = UNNotificationRequest(identifier: task.id, content: content, trigger: trigger)
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

//TESTING works right now
import Foundation
import UserNotifications
import SwiftUI

//class NotificationManager {
//    static let shared = NotificationManager()
//
//    private init() {}
//
//    func requestPermission(completion: @escaping (Bool) -> Void) {
//        let notificationCenter = UNUserNotificationCenter.current()
//        notificationCenter.getNotificationSettings { settings in
//            DispatchQueue.main.async {
//                switch settings.authorizationStatus {
//                case .authorized:
//                    print("Notifications are already authorized.")
//                    completion(true)
//                case .denied:
//                    print("Notifications are denied.")
//                    completion(false)
//                case .notDetermined:
//                    notificationCenter.requestAuthorization(options: [.alert, .sound]) { didAllow, error in
//                        DispatchQueue.main.async {
//                            if didAllow {
//                                print("Notifications granted.")
//                                completion(true)
//                            } else {
//                                print("Notifications denied.")
//                                completion(false)
//                            }
//                        }
//                    }
//                default:
//                    completion(false)
//                }
//            }
//        }
//    }
//WORKING AND USING

class NotificationManager {
    static let shared = NotificationManager()
    
    func requestPermission(completion: @escaping (Bool) -> Void) {
        let notificationCenter = UNUserNotificationCenter.current()
        
        notificationCenter.getNotificationSettings { settings in
            DispatchQueue.main.async {
                switch settings.authorizationStatus {
                case .authorized, .provisional:
                    print("Notifications granted.")
                    UserDefaults.standard.set(true, forKey: "notificationsEnabled")
                    completion(true)
                case .denied:
                    print("Notifications denied.")
                    UserDefaults.standard.set(false, forKey: "notificationsEnabled")
                    completion(false)
                case .notDetermined:
                    notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
                        DispatchQueue.main.async {
                            if granted {
                                print("Notifications allowed.")
                                UserDefaults.standard.set(true, forKey: "notificationsEnabled")
                            } else {
                                print("Notifications denied.")
                                UserDefaults.standard.set(false, forKey: "notificationsEnabled")
                            }
                            completion(granted)
                        }
                    }
                default:
                    completion(false)
                }
            }
        }
    }
    
        // working and using
    
    func scheduleNotification(for task: ToDoListitem) {
        guard let notifyBefore = task.notifyBefore else { return }
        
        let notificationTime = task.dueDate - notifyBefore
        if notificationTime < Date().timeIntervalSince1970 {
            print("Notification time is in the past. Skipping.")
            return
        }
        
        let content = UNMutableNotificationContent()
        content.title = "Task Reminder"

        let dueDate = Date(timeIntervalSince1970: task.dueDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        let formattedDueDate = dateFormatter.string(from: dueDate)

        let taskDescription = task.description ?? "No description provided"
        content.body = "Your task \"\(task.title)\" is due on \(formattedDueDate) \(taskDescription)"
        content.sound = .default

        
        let triggerDate = Date(timeIntervalSince1970: notificationTime)
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: triggerDate),
            repeats: false
        )
        
        let request = UNNotificationRequest(identifier: task.id, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled for \(task.title) at \(triggerDate)")
            }
        }
    }
    
    
    

//    func scheduleNotification(for task: ToDoListitem) {
//        guard !task.isDeleted, let notifyBefore = task.notifyBefore else {
//            print("Task has been deleted or no notification time is set.")
//            return
//        }
//
//        let notificationTime = task.dueDate - notifyBefore
//        if notificationTime < Date().timeIntervalSince1970 {
//            print("Notification time is in the past. Skipping.")
//            return
//        }
//
//        let content = UNMutableNotificationContent()
//        content.title = "Task Reminder"
//
//        let dueDate = Date(timeIntervalSince1970: task.dueDate)
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateStyle = .medium
//        dateFormatter.timeStyle = .short
//        let formattedDueDate = dateFormatter.string(from: dueDate)
//
//        let taskDescription = task.description ?? "No description provided"
//        content.body = "Your task \"\(task.title)\" is due on \(formattedDueDate) \(taskDescription)"
//        content.sound = .default
//
//        let triggerDate = Date(timeIntervalSince1970: notificationTime)
//        let trigger = UNCalendarNotificationTrigger(
//            dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: triggerDate),
//            repeats: false
//        )
//
//        let request = UNNotificationRequest(identifier: task.id, content: content, trigger: trigger)
//        UNUserNotificationCenter.current().add(request) { error in
//            if let error = error {
//                print("Error scheduling notification: \(error.localizedDescription)")
//            } else {
//                print("Notification scheduled for \(task.title) at \(triggerDate)")
//            }
//        }
//    }

    
    func removeNotification(for taskId: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [taskId])
        print("Removed notification for task ID: \(taskId)")
    }

    func removeAllNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        print("All notifications removed.")
    }
}
