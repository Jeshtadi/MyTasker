//
//  NotificationManager.swift
//  MyTasker
//
//  Created by Anushya Jeshtadi on 10/02/2025.
//

import Foundation
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()
    
    private init() {}
    
    /// Request notification permissions from the user
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Error requesting permission: \(error.localizedDescription)")
            } else {
                print("Notification permission granted: \(granted)")
            }
        }
    }
    
    /// Schedule a notification for a task
    func scheduleNotification(for task: ToDoListitem) {
        guard let notifyBefore = task.notifyBefore else { return } // If no notification time, exit
        
        let notificationTime = task.dueDate - notifyBefore  // Calculate notification time
        
        // Prevent scheduling notifications in the past
        if notificationTime < Date().timeIntervalSince1970 { return }
        
        let content = UNMutableNotificationContent()
        content.title = "Task Reminder"
        content.body = "Don't forget: \(task.title)"
        content.sound = .default
        
        let triggerDate = Date(timeIntervalSince1970: notificationTime)
        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: triggerDate), repeats: false)

        let request = UNNotificationRequest(identifier: task.id, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled for \(task.title) at \(triggerDate)")
            }
        }
    }
    
    /// Remove a scheduled notification (if task is deleted or updated)
    func removeNotification(for taskId: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [taskId])
        print("Removed notification for task ID: \(taskId)")
    }
}
