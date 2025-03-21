//
//  NotificationViewModel.swift
//  MyTasker
//
//  Created by Anushya Jeshtadi on 10/02/2025.
//

import Foundation

class NotificationViewModel: ObservableObject {
    init() {
        NotificationManager.shared.requestPermission() // Ask for notification permissions at app launch
    }

    /// Schedule a notification when a new task is added
    func addTaskNotification(task: ToDoListitem) {
        NotificationManager.shared.scheduleNotification(for: task)
    }

    /// Remove notification if task is deleted
    func removeTaskNotification(taskId: String) {
        NotificationManager.shared.removeNotification(for: taskId)
    }
}
