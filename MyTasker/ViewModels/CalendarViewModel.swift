//
//  CalendarViewModel.swift
//  MyTasker
//
//  Created by Anushya Jeshtadi on 10/03/2025.
//
import SwiftUI
import Firebase

class CalendarViewModel: ObservableObject {
    @Published var tasks: [ToDoListitem] = []
    @Published var events: [MoodleEvent] = []
    
    private let db = Firestore.firestore()  // Firebase Firestore instance
    
    // Function to fetch tasks from Firebase for a specific date
    func fetchTasks(for date: Date) {
        let startOfDay = Calendar.current.startOfDay(for: date)
        let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)!
        
        // Fetch tasks where the dueDate is within the selected day's range
        db.collection("tasks")
            .whereField("dueDate", isGreaterThanOrEqualTo: startOfDay.timeIntervalSince1970)
            .whereField("dueDate", isLessThan: endOfDay.timeIntervalSince1970)
            .getDocuments { [weak self] (snapshot, error) in
                if let error = error {
                    print("Error fetching tasks: \(error.localizedDescription)")
                    return
                }
                
                // Parse the fetched documents into ToDoListitem objects
                self?.tasks = snapshot?.documents.compactMap { doc -> ToDoListitem? in
                    try? doc.data(as: ToDoListitem.self)
                } ?? []
            }
    }
    
    // Function to fetch events from Firebase for a specific date
    func fetchEvents(for date: Date) {
        let startOfDay = Calendar.current.startOfDay(for: date)
        let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)!
        
        // Fetch events that occur on the selected day
        db.collection("events")
            .whereField("startDate", isGreaterThanOrEqualTo: startOfDay.timeIntervalSince1970)
            .whereField("startDate", isLessThan: endOfDay.timeIntervalSince1970)
            .getDocuments { [weak self] (snapshot, error) in
                if let error = error {
                    print("Error fetching events: \(error.localizedDescription)")
                    return
                }
                
                // Parse the fetched documents into MoodleEvent objects
                self?.events = snapshot?.documents.compactMap { doc -> MoodleEvent? in
                    try? doc.data(as: MoodleEvent.self)
                } ?? []
            }
    }
}
