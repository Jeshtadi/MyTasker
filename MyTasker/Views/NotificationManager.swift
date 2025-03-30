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
//



//WORKING
//import Foundation
//import UserNotifications
//
//class NotificationManager {
//    static let shared = NotificationManager()
//
//    private init() {}
//
//    /// Request Notification Permission
//    func requestPermission() {
//        let notificationCenter = UNUserNotificationCenter.current()
//        notificationCenter.getNotificationSettings { settings in
//            switch settings.authorizationStatus {
//            case .authorized:
//                print("Notifications are already authorized.")
//            case .denied:
//                print("Notifications are denied.")
//                return
//            case .notDetermined:
//                notificationCenter.requestAuthorization(options: [.alert, .sound]) { didAllow, error in
//                    if didAllow {
//                        print("Notifications granted.")
//                    } else {
//                        print("Notifications denied.")
//                    }
//                }
//            default:
//                return
//            }
//        }
//    }
//
//    /// Schedule a notification for a task
//    func scheduleNotification(for task: ToDoListitem) {
//        guard UserDefaults.standard.bool(forKey: "notificationsEnabled") else {
//            print("Notifications are disabled. Skipping scheduling.")
//            return
//        }
//
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
//
//    /// Remove all notifications (when the user disables notifications)
//    func removeAllNotifications() {
//        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
//        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
//        print("All notifications removed.")
//    }
//}



//TESTING
import Foundation
import UserNotifications
import SwiftUI

class NotificationManager {
    static let shared = NotificationManager()

    private init() {}

    func requestPermission(completion: @escaping (Bool) -> Void) {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { settings in
            DispatchQueue.main.async {
                switch settings.authorizationStatus {
                case .authorized:
                    print("Notifications are already authorized.")
                    completion(true)
                case .denied:
                    print("Notifications are denied.")
                    completion(false)
                case .notDetermined:
                    notificationCenter.requestAuthorization(options: [.alert, .sound]) { didAllow, error in
                        DispatchQueue.main.async {
                            if didAllow {
                                print("Notifications granted.")
                                completion(true)
                            } else {
                                print("Notifications denied.")
                                completion(false)
                            }
                        }
                    }
                default:
                    completion(false)
                }
            }
        }
    }

    func scheduleNotification(for task: ToDoListitem) {
        guard UserDefaults.standard.bool(forKey: "notificationsEnabled") else {
            print("Notifications are disabled. Skipping scheduling.")
            return
        }

        guard let notifyBefore = task.notifyBefore else { return }

        let notificationTime = task.dueDate - notifyBefore
        if notificationTime < Date().timeIntervalSince1970 {
            print("Notification time is in the past. Skipping.")
            return
        }

        let content = UNMutableNotificationContent()
        content.title = "Task Reminder"
        content.body = "Your task: \(task.title)"
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
