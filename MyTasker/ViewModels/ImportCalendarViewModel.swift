//
//  SwiftUIView.swift
//  MyTasker
//
//  Created by Anushya Jeshtadi on 02/03/2025.
//WORKING FOR ONE DESCRIPTION
//import SwiftUI
//import Foundation
//import FirebaseAuth
//import FirebaseFirestore
//
//class ImportCalendarViewModel: ObservableObject {
// 
//    @Published var events: [MoodleEvent] = []
//    @Published var moodleURL: String = ""
//
//
//    private let db = Firestore.firestore()
//    init() {
//        loadEventsFromFirestore()
//    }
//
//    func importCalendar() {
//            guard let url = URL(string: moodleURL) else {
//                print("Invalid URL")
//                return
//            }
//
//            let task = URLSession.shared.dataTask(with: url) { data, response, error in
//                if let error = error {
//                    print("Error fetching .ics file: \(error)")
//                    return
//                }
//
//                if let data = data, let icsString = String(data: data, encoding: .utf8) {
//                    let parsedEvents = self.parseICS(icsString)
//
//                    DispatchQueue.main.async {
//                        self.events = parsedEvents
//                        self.saveEventsToFirestore(events: parsedEvents)
//                    }
//                }
//            }
//            task.resume()
//        }
//    
//
////
////        private func cleanDescription(_ description: String) -> String {
////            var cleanedDescription = description
////             
////            cleanedDescription = cleanedDescription.replacingOccurrences(of: "\n", with: "")
////             
////            cleanedDescription = cleanedDescription.replacingOccurrences(of: "\\n", with: "\n")
////             
////            cleanedDescription = cleanedDescription.replacingOccurrences(of: "\n([a-z])", with: " $1", options: .regularExpression)
////            
////            cleanedDescription = cleanedDescription.replacingOccurrences(of: "\n\t* ", with: "\n• ", options: .regularExpression)
////            cleanedDescription = cleanedDescription.trimmingCharacters(in: .whitespacesAndNewlines)
////
////            return cleanedDescription
////        }
//        private func cleanDescription(_ description: String) -> String {
//            var cleanedDescription = description
//
//            // Replace ICS escape sequences
//            cleanedDescription = cleanedDescription.replacingOccurrences(of: "\n", with: "")
//            cleanedDescription = cleanedDescription.replacingOccurrences(of: "\\n", with: "\n") // Convert ICS \n to actual newlines
//            cleanedDescription = cleanedDescription.replacingOccurrences(of: "\\,", with: ",")  // Remove escaped commas
//            cleanedDescription = cleanedDescription.replacingOccurrences(of: "\\;", with: ";")  // Remove escaped semicolons
//            cleanedDescription = cleanedDescription.replacingOccurrences(of: "\\", with: "")
//            cleanedDescription = cleanedDescription.replacingOccurrences(of: "\n+", with: "\n", options: .regularExpression)
//            cleanedDescription = cleanedDescription.replacingOccurrences(of: "  +", with: " ", options: .regularExpression)
//            cleanedDescription = cleanedDescription.replacingOccurrences(of: "\n([a-z])", with: " $1", options: .regularExpression)
// 
//            cleanedDescription = cleanedDescription.replacingOccurrences(of: "\n\t* ", with: "\n• ", options: .regularExpression)
//            cleanedDescription = cleanedDescription.replacingOccurrences(of: "\n- ", with: "\n• ", options: .regularExpression)
//            cleanedDescription = cleanedDescription.trimmingCharacters(in: .whitespacesAndNewlines)
//
//            return cleanedDescription
//        }
//
//    
//
//        private func parseICS(_ icsString: String) -> [MoodleEvent] {
//            let lines = icsString.components(separatedBy: "\n")
//            var event: [String: String] = [:]
//            var events: [MoodleEvent] = []
//            var currentDescription = ""
//            var isCollectingDescription = false
//
//            for line in lines {
//                if line.hasPrefix("BEGIN:VEVENT") {
//                    event = [:]
//                    currentDescription = ""
//                    isCollectingDescription = false
//                } else if line.hasPrefix("END:VEVENT") {
//                    if let id = event["UID"],
//                       let title = event["SUMMARY"],
//                       let startDateStr = event["DTSTART"],
//                       let endDateStr = event["DTEND"],
//                       let startDate = parseDate(startDateStr),
//                       let endDate = parseDate(endDateStr) {
//                        
//                        // Clean up description before storing
//                        currentDescription = cleanDescription(currentDescription)
//
//                        let moodleEvent = MoodleEvent(
//                            id: id,
//                            title: title,
//                            startDate: startDate.timeIntervalSince1970,
//                            endDate: endDate.timeIntervalSince1970,
//                            description: currentDescription.isEmpty ? "No description" : currentDescription,
//                            notifyBefore: nil
//                        )
//
//                        events.append(moodleEvent)
//                    }
//                } else {
//                    let parts = line.split(separator: ":", maxSplits: 1)
//                    if parts.count == 2 {
//                        let key = String(parts[0]).trimmingCharacters(in: .whitespaces)
//                        let value = String(parts[1]).trimmingCharacters(in: .whitespaces)
//
//                        if key == "DESCRIPTION" {
//                            // Start collecting the description
//                            currentDescription = value
//                            isCollectingDescription = true
//                        } else {
//                            event[key] = value
//                            isCollectingDescription = false
//                        }
//                    } else if isCollectingDescription {
//                        // Handle multi-line description (continued on next line)
//                        currentDescription += " " + line.trimmingCharacters(in: .whitespaces)
//                    }
//                }
//            }
//            return events
//        }
//
//
//        private func saveEventsToFirestore(events: [MoodleEvent]) {
//            guard let userId = Auth.auth().currentUser?.uid else { return }
//
//            let userEventsRef = db.collection("users").document(userId).collection("moodleEvents")
//
//            userEventsRef.getDocuments { snapshot, _ in
//                for doc in snapshot?.documents ?? [] {
//                    userEventsRef.document(doc.documentID).delete()
//                }
//
//                for event in events {
//                    var eventData: [String: Any] = [
//                        "id": event.id,
//                        "title": event.title,
//                        "startDate": event.startDate,
//                        "endDate": event.endDate,
//                        "notifyBefore": event.notifyBefore ?? 0
//                    ]
//
//                    if let description = event.description, !description.isEmpty {
//                        eventData["description"] = description
//                    }
//
//                    userEventsRef.document(event.id).setData(eventData)
//                }
//            }
//        }
//
//
//
//        private func parseDate(_ dateString: String) -> Date? {
//            let isoFormatter = ISO8601DateFormatter()
//            isoFormatter.formatOptions = [.withYear, .withMonth, .withDay, .withTime, .withTimeZone]
//
//            return isoFormatter.date(from: dateString.trimmingCharacters(in: .whitespacesAndNewlines))
//        }
//    
//    
//
//        func loadEventsFromFirestore() {
//            guard let userId = Auth.auth().currentUser?.uid else { return }
//
//            db.collection("users").document(userId).collection("moodleEvents")
//                .getDocuments { snapshot, error in
//                    if let error = error {
//                        print("Error loading events: \(error.localizedDescription)")
//                        return
//                    }
//
//                    if let documents = snapshot?.documents {
//                        DispatchQueue.main.async {
//                            self.events = documents.compactMap { doc in
//                                let data = doc.data()
//                                return MoodleEvent(
//                                    id: data["id"] as? String ?? UUID().uuidString,
//                                    title: data["title"] as? String ?? "Unknown",
//                                    startDate: data["startDate"] as? TimeInterval ?? 0,
//                                    endDate: data["endDate"] as? TimeInterval ?? 0,
//                                    description: data["description"] as? String,
//                                    notifyBefore: data["notifyBefore"] as? TimeInterval
//                                )
//                            }
//                        }
//                    }
//                }
//        }
//
//    }






//
////
//////working code for moodle
//import SwiftUI
//import Foundation
//import FirebaseAuth
//import FirebaseFirestore
//
//class ImportCalendarViewModel: ObservableObject {
//
//    @Published var events: [MoodleEvent] = []
//    @Published var moodleURL: String = ""
//
//    private let db = Firestore.firestore()
//
//    init() {
//        loadEventsFromFirestore()
//    }
//
////    func importCalendar() {
////        guard let url = URL(string: moodleURL) else {
////            print("Invalid URL")
////            return
////        }
////
////        let task = URLSession.shared.dataTask(with: url) { data, response, error in
////            if let error = error {
////                print("Error fetching .ics file: \(error)")
////                return
////            }
////
////            if let data = data, let icsString = String(data: data, encoding: .utf8) {
////                let parsedEvents = self.parseICS(icsString)
////
////                DispatchQueue.main.async {
////                    self.events = parsedEvents
////                    self.saveEventsToFirestore(events: parsedEvents)
////                }
////            }
////        }
////        task.resume()
////    }
//    
//    func importCalendar(completion: @escaping (String?) -> Void) {
//        let trimmedURL = moodleURL.trimmingCharacters(in: .whitespacesAndNewlines)
//
//        guard let url = URL(string: trimmedURL), !trimmedURL.isEmpty else {
//            completion("Invalid Moodle Calendar URL.")
//            return
//        }
//
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                DispatchQueue.main.async {
//                    completion("Error fetching .ics file: \(error.localizedDescription)")
//                }
//                return
//            }
//
//            if let data = data, let icsString = String(data: data, encoding: .utf8) {
//                let parsedEvents = self.parseICS(icsString)
//
//                DispatchQueue.main.async {
//                    self.events = parsedEvents
//                    self.saveEventsToFirestore(events: parsedEvents)
//                    completion(nil) // No error
//                }
//            } else {
//                DispatchQueue.main.async {
//                    completion("Failed to load calendar data. Please check your URL.")
//                }
//            }
//        }
//        task.resume()
//    }
//
//
//    //FROM THE TESTING
////    func cleanDescription(_ description: String) -> String {
////        var cleanedDescription = description
////
////        cleanedDescription = cleanedDescription.replacingOccurrences(of: "\\n", with: "")
////        cleanedDescription = cleanedDescription.replacingOccurrences(of: "\\n", with: "\n")
////    
////        cleanedDescription = cleanedDescription.replacingOccurrences(of: "\n([a-z])", with: " $1", options: .regularExpression)
////        
////        cleanedDescription = cleanedDescription.replacingOccurrences(of: "\n\t* ", with: "\n• ", options: .regularExpression)
//// 
////        cleanedDescription = cleanedDescription.trimmingCharacters(in: .whitespacesAndNewlines)
////
////        return cleanedDescription
////    }
//    
//    
//    private func cleanDescription(_ description: String) -> String {
//                var cleanedDescription = description
//    
//                // Replace ICS escape sequences
//                cleanedDescription = cleanedDescription.replacingOccurrences(of: "\n", with: "")
//                cleanedDescription = cleanedDescription.replacingOccurrences(of: "\\n", with: "\n") // Convert ICS \n to actual newlines
//                cleanedDescription = cleanedDescription.replacingOccurrences(of: "\\,", with: ",")  // Remove escaped commas
//                cleanedDescription = cleanedDescription.replacingOccurrences(of: "\\;", with: ";")  // Remove escaped semicolons
//                cleanedDescription = cleanedDescription.replacingOccurrences(of: "\\", with: "")
//                cleanedDescription = cleanedDescription.replacingOccurrences(of: "\n+", with: "\n", options: .regularExpression)
//                cleanedDescription = cleanedDescription.replacingOccurrences(of: "  +", with: " ", options: .regularExpression)
//                cleanedDescription = cleanedDescription.replacingOccurrences(of: "\n([a-z])", with: " $1", options: .regularExpression)
//    
//                cleanedDescription = cleanedDescription.replacingOccurrences(of: "\n\t* ", with: "\n• ", options: .regularExpression)
//                cleanedDescription = cleanedDescription.replacingOccurrences(of: "\n- ", with: "\n• ", options: .regularExpression)
//                cleanedDescription = cleanedDescription.trimmingCharacters(in: .whitespacesAndNewlines)
//    
//                return cleanedDescription
//            }
//
////    private func parseICS(_ icsString: String) -> [MoodleEvent] {
////        let lines = icsString.components(separatedBy: "\n")
////        var event: [String: String] = [:]
////        var events: [MoodleEvent] = []
////        var currentDescription = ""
////        var isCollectingDescription = false
////
////        for line in lines {
////            if line.hasPrefix("BEGIN:VEVENT") {
////                event = [:]
////                currentDescription = ""
////                isCollectingDescription = false
////            } else if line.hasPrefix("END:VEVENT") {
////                if let id = event["UID"],
////                   let title = event["SUMMARY"],
////                   let startDateStr = event["DTSTART"],
////                   let endDateStr = event["DTEND"],
////                   let startDate = parseDate(startDateStr),
////                   let endDate = parseDate(endDateStr) {
////
////                    // Clean up description before storing
////                    currentDescription = cleanDescription(currentDescription)
////
////                    let moodleEvent = MoodleEvent(
////                        id: id,
////                        title: title,
////                        startDate: startDate.timeIntervalSince1970,
////                        endDate: endDate.timeIntervalSince1970,
////                        description: currentDescription.isEmpty ? "No description" : currentDescription,
////                        notifyBefore: nil
////                    )
////
////                    events.append(moodleEvent)
////                }
////            } else {
////                let parts = line.split(separator: ":", maxSplits: 1)
////                if parts.count == 2 {
////                    let key = String(parts[0]).trimmingCharacters(in: .whitespaces)
////                    let value = String(parts[1]).trimmingCharacters(in: .whitespaces)
////
////                    if key == "DESCRIPTION" {
////                        // Start collecting the description
////                        currentDescription = value
////                        isCollectingDescription = true
////                    } else {
////                        event[key] = value
////                        isCollectingDescription = false
////                    }
////                } else if isCollectingDescription {
////                    // Handle multi-line description (continued on next line)
////                    currentDescription += " " + line.trimmingCharacters(in: .whitespaces)
////                }
////            }
////        }
////        return events
////    }
//    
//    
//    private func parseICS(_ icsString: String) -> [MoodleEvent] {
//        let lines = icsString.components(separatedBy: "\n")
//        var event: [String: String] = [:]
//        var events: [MoodleEvent] = []
//        var currentDescription = ""
//        var isCollectingDescription = false
//
//        for line in lines {
//            if line.hasPrefix("BEGIN:VEVENT") {
//                event = [:]
//                currentDescription = ""
//                isCollectingDescription = false
//            } else if line.hasPrefix("END:VEVENT") {
//                if let id = event["UID"],
//                   let title = event["SUMMARY"],
//                   let startDateStr = event["DTSTART"],
//                   let endDateStr = event["DTEND"],
//                   let startDate = parseDate(startDateStr),
//                   let endDate = parseDate(endDateStr) {
//                    
//                    // Create event with raw description first
//                    let moodleEvent = MoodleEvent(
//                        id: id,
//                        title: title,
//                        startDate: startDate.timeIntervalSince1970,
//                        endDate: endDate.timeIntervalSince1970,
//                        description: currentDescription.isEmpty ? "No description" : currentDescription,
//                        notifyBefore: nil
//                    )
//
//                    // Convert description to attributed format using the struct function
//                    let attributedDescription = moodleEvent.attributedDescription().string
//                    
//                    // Create a new MoodleEvent with the cleaned description
//                    let finalEvent = MoodleEvent(
//                        id: moodleEvent.id,
//                        title: moodleEvent.title,
//                        startDate: moodleEvent.startDate,
//                        endDate: moodleEvent.endDate,
//                        description: attributedDescription,
//                        notifyBefore: moodleEvent.notifyBefore
//                    )
//
//                    events.append(finalEvent)
//                }
//            } else {
//                let parts = line.split(separator: ":", maxSplits: 1)
//                if parts.count == 2 {
//                    let key = String(parts[0]).trimmingCharacters(in: .whitespaces)
//                    let value = String(parts[1]).trimmingCharacters(in: .whitespaces)
//
//                    if key == "DESCRIPTION" {
//                        // Start collecting the description
//                        currentDescription = value
//                        isCollectingDescription = true
//                    } else {
//                        event[key] = value
//                        isCollectingDescription = false
//                    }
//                } else if isCollectingDescription {
//                    // Handle multi-line description (continued on the next line)
//                    currentDescription += " " + line.trimmingCharacters(in: .whitespaces)
//                }
//            }
//        }
//        return events
//    }
//
//    
//
//    private func saveEventsToFirestore(events: [MoodleEvent]) {
//        guard let userId = Auth.auth().currentUser?.uid else { return }
//
//        let userEventsRef = db.collection("users").document(userId).collection("moodleEvents")
//
//        userEventsRef.getDocuments { snapshot, _ in
//            for doc in snapshot?.documents ?? [] {
//                userEventsRef.document(doc.documentID).delete()
//            }
//
//            for event in events {
//                var eventData: [String: Any] = [
//                    "id": event.id,
//                    "title": event.title,
//                    "startDate": event.startDate,
//                    "endDate": event.endDate,
//                    "notifyBefore": event.notifyBefore ?? 0
//                ]
//
//                if !event.description.isEmpty {
//                    eventData["description"] = event.description
//                            }
//
//                userEventsRef.document(event.id).setData(eventData)
//            }
//        }
//    }
//
//    private func parseDate(_ dateString: String) -> Date? {
//        let isoFormatter = ISO8601DateFormatter()
//        isoFormatter.formatOptions = [.withYear, .withMonth, .withDay, .withTime, .withTimeZone]
//
//        return isoFormatter.date(from: dateString.trimmingCharacters(in: .whitespacesAndNewlines))
//    }
//
//    func loadEventsFromFirestore() {
//        guard let userId = Auth.auth().currentUser?.uid else { return }
//
//        db.collection("users").document(userId).collection("moodleEvents")
//            .getDocuments { snapshot, error in
//                if let error = error {
//                    print("Error loading events: \(error.localizedDescription)")
//                    return
//                }
//
//                if let documents = snapshot?.documents {
//                    DispatchQueue.main.async {
//                        self.events = documents.compactMap { doc in
//                            let data = doc.data()
//                            return MoodleEvent(
//                                id: data["id"] as? String ?? UUID().uuidString,
//                                title: data["title"] as? String ?? "Unknown",
//                                startDate: data["startDate"] as? TimeInterval ?? 0,
//                                endDate: data["endDate"] as? TimeInterval ?? 0,
//                                description: data["description"] as? String ?? "No description",
//                                notifyBefore: data["notifyBefore"] as? TimeInterval
//                            )
//                        }
//                    }
//                }
//            }
//    }
//}





//working on right now

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class ImportCalendarViewModel: ObservableObject {

    @Published var events: [MoodleEvent] = []
    @Published var moodleURL: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var isImportComplete: Bool = false  // Added to control navigation
    
    private let db = Firestore.firestore()

    init() {
        loadEventsFromFirestore()
    }

//    func importCalendar(completion: @escaping (String?) -> Void) {
//        let trimmedURL = moodleURL.trimmingCharacters(in: .whitespacesAndNewlines)
//
//        guard !trimmedURL.isEmpty, let url = URL(string: trimmedURL) else {
//            self.errorMessage = "Invalid Moodle Calendar URL."
//            completion("Invalid Moodle Calendar URL.") // Returning error message through completion
//            return
//        }
//
//        isLoading = true
//        errorMessage = nil
//
//        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
//            guard let self = self else { return }
//
//            if let error = error {
//                DispatchQueue.main.async {
//                    self.isLoading = false
//                    self.errorMessage = "Error fetching .ics file: \(error.localizedDescription)"
//                    completion(self.errorMessage) // Return error through completion
//                }
//                return
//            }
//
//            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
//                DispatchQueue.main.async {
//                    self.isLoading = false
//                    self.errorMessage = "Server returned status code \(httpResponse.statusCode). Please check the URL."
//                    completion(self.errorMessage) // Return error through completion
//                }
//                return
//            }
//
//            if let data = data, let icsString = String(data: data, encoding: .utf8) {
//                let parsedEvents = self.parseICS(icsString)
//
//                DispatchQueue.main.async {
//                    self.events = parsedEvents
//                    self.saveEventsToFirestore(events: parsedEvents)
//                    self.isLoading = false
//                    self.isImportComplete = true  // Trigger navigation
//                    completion(nil) // Return success (nil indicates no error)
//                }
//            } else {
//                DispatchQueue.main.async {
//                    self.isLoading = false
//                    self.errorMessage = "Failed to load calendar data. Please check your URL."
//                    completion(self.errorMessage) // Return error through completion
//                }
//            }
//        }
//        task.resume()
//    }

    
    
    func importCalendar(completion: @escaping (String?) -> Void) {
        let trimmedURL = moodleURL.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmedURL.isEmpty, let url = URL(string: trimmedURL) else {
            self.errorMessage = "Invalid Moodle Calendar URL."
            completion("Invalid Moodle Calendar URL.")
            return
        }

        isLoading = true
        errorMessage = nil

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }

            if let error = error {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.errorMessage = "Error fetching .ics file: \(error.localizedDescription)"
                    completion(self.errorMessage)
                }
                return
            }

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.errorMessage = "Server returned status code \(httpResponse.statusCode). Please check the URL."
                    completion(self.errorMessage)
                }
                return
            }

            if let data = data, let icsString = String(data: data, encoding: .utf8) {
                let parsedEvents = self.parseICS(icsString)

                DispatchQueue.main.async {
                    self.events = parsedEvents
                    self.saveEventsToFirestore(events: parsedEvents) {
                        self.loadEventsFromFirestore()  // Refresh the view after import
                    }
                    self.isLoading = false
                    self.isImportComplete = true
                    completion(nil)
                }
            } else {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.errorMessage = "Failed to load calendar data. Please check your URL."
                    completion(self.errorMessage)
                }
            }
        }
        task.resume()
    }


    private func parseICS(_ icsString: String) -> [MoodleEvent] {
        let lines = icsString.components(separatedBy: "\n")
        var event: [String: String] = [:]
        var events: [MoodleEvent] = []
        var currentDescription = ""
        var isCollectingDescription = false

        for line in lines {
            if line.hasPrefix("BEGIN:VEVENT") {
                event = [:]
                currentDescription = ""
                isCollectingDescription = false
            } else if line.hasPrefix("END:VEVENT") {
                if let id = event["UID"],
                   let title = event["SUMMARY"],
                   let startDateStr = event["DTSTART"],
                   let endDateStr = event["DTEND"],
                   let startDate = parseDate(startDateStr),
                   let endDate = parseDate(endDateStr) {
                    
                    // Create event with raw description first
                    let moodleEvent = MoodleEvent(
                        id: id,
                        title: title,
                        startDate: startDate.timeIntervalSince1970,
                        endDate: endDate.timeIntervalSince1970,
                        description: currentDescription.isEmpty ? "No description" : currentDescription,
                        notifyBefore: nil
                    )

                    // Clean and format description
                    let attributedDescription = self.cleanDescription(moodleEvent.description)

                    // Create a new MoodleEvent with the cleaned description
                    let finalEvent = MoodleEvent(
                        id: moodleEvent.id,
                        title: moodleEvent.title,
                        startDate: moodleEvent.startDate,
                        endDate: moodleEvent.endDate,
                        description: attributedDescription,
                        notifyBefore: moodleEvent.notifyBefore
                    )

                    events.append(finalEvent)
                }
            } else {
                let parts = line.split(separator: ":", maxSplits: 1)
                if parts.count == 2 {
                    let key = String(parts[0]).trimmingCharacters(in: .whitespaces)
                    let value = String(parts[1]).trimmingCharacters(in: .whitespaces)

                    if key == "DESCRIPTION" {
                        // Collect the description content
                        currentDescription = value
                        isCollectingDescription = true
                    } else {
                        event[key] = value
                        isCollectingDescription = false
                    }
                } else if isCollectingDescription {
                    // Handle multi-line description (continued on next line)
                    currentDescription += " " + line.trimmingCharacters(in: .whitespaces)
                }
            }
        }
        return events
    }
    
    private func saveEventsToFirestore(events: [MoodleEvent], completion: @escaping () -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else { return }

        let userEventsRef = db.collection("users").document(userId).collection("moodleEvents")

        userEventsRef.getDocuments { snapshot, _ in
            for doc in snapshot?.documents ?? [] {
                userEventsRef.document(doc.documentID).delete()
            }

            let dispatchGroup = DispatchGroup()

            for event in events {
                dispatchGroup.enter()
                var eventData: [String: Any] = [
                    "id": event.id,
                    "title": event.title,
                    "startDate": event.startDate,
                    "endDate": event.endDate,
                    "notifyBefore": event.notifyBefore ?? 0
                ]

                if !event.description.isEmpty {
                    eventData["description"] = event.description
                }

                userEventsRef.document(event.id).setData(eventData) { _ in
                    dispatchGroup.leave()
                }
            }

            dispatchGroup.notify(queue: .main) {
                completion()  // Ensure the refresh happens after Firestore update
            }
        }
    }


//    private func saveEventsToFirestore(events: [MoodleEvent]) {
//        guard let userId = Auth.auth().currentUser?.uid else { return }
//
//        let userEventsRef = db.collection("users").document(userId).collection("moodleEvents")
//
//        // Clear existing events
//        userEventsRef.getDocuments { snapshot, _ in
//            for doc in snapshot?.documents ?? [] {
//                userEventsRef.document(doc.documentID).delete()
//            }
//
//            // Save new events
//            for event in events {
//                var eventData: [String: Any] = [
//                    "id": event.id,
//                    "title": event.title,
//                    "startDate": event.startDate,
//                    "endDate": event.endDate,
//                    "notifyBefore": event.notifyBefore ?? 0
//                ]
//
//                if !event.description.isEmpty {
//                    eventData["description"] = event.description
//                }
//
//                userEventsRef.document(event.id).setData(eventData)
//            }
//        }
//    }

    private func parseDate(_ dateString: String) -> Date? {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withYear, .withMonth, .withDay, .withTime, .withTimeZone]

        return isoFormatter.date(from: dateString.trimmingCharacters(in: .whitespacesAndNewlines))
    }

    private func cleanDescription(_ description: String) -> String {
        var cleanedDescription = description

        cleanedDescription = cleanedDescription.replacingOccurrences(of: "\\n", with: "\n")  // Convert ICS \n to actual newlines
        cleanedDescription = cleanedDescription.replacingOccurrences(of: "\\,", with: ",")   // Remove escaped commas
        cleanedDescription = cleanedDescription.replacingOccurrences(of: "\\;", with: ";")   // Remove escaped semicolons
        cleanedDescription = cleanedDescription.replacingOccurrences(of: "\\", with: "")
        cleanedDescription = cleanedDescription.replacingOccurrences(of: "\n+", with: "\n", options: .regularExpression)
        cleanedDescription = cleanedDescription.replacingOccurrences(of: "  +", with: " ", options: .regularExpression)
        cleanedDescription = cleanedDescription.trimmingCharacters(in: .whitespacesAndNewlines)

        return cleanedDescription
    }

    func loadEventsFromFirestore() {
        guard let userId = Auth.auth().currentUser?.uid else { return }

        db.collection("users").document(userId).collection("moodleEvents")
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error loading events: \(error.localizedDescription)")
                    return
                }

                if let documents = snapshot?.documents {
                    DispatchQueue.main.async {
                        self.events = documents.compactMap { doc in
                            let data = doc.data()
                            return MoodleEvent(
                                id: data["id"] as? String ?? UUID().uuidString,
                                title: data["title"] as? String ?? "Unknown",
                                startDate: data["startDate"] as? TimeInterval ?? 0,
                                endDate: data["endDate"] as? TimeInterval ?? 0,
                                description: data["description"] as? String ?? "No description",
                                notifyBefore: data["notifyBefore"] as? TimeInterval
                            )
                        }
                    }
                }
            }
    }
}







//
//trying for google calendear
//import SwiftUI
//import Foundation
//import FirebaseAuth
//import FirebaseFirestore
//
//class ImportCalendarViewModel: ObservableObject {
//    @Published var moodleCalendarURL: String = ""
//    @Published var googleCalendarURL: String = ""
//    @Published var moodleEvents: [MoodleEvent] = []
//    @Published var googleEvents: [CalendarEvent] = []
//    
//    private let db = Firestore.firestore()
//    
//    init() {
//        loadCalendarURLs()
//        loadEventsFromFirestore()
//    }
//    
//    // Save URLs to Firestore
//    func saveCalendarURL(isMoodle: Bool) {
//        guard let userId = Auth.auth().currentUser?.uid else { return }
//        let urlKey = isMoodle ? "moodleCalendarURL" : "googleCalendarURL"
//        let urlValue = isMoodle ? moodleCalendarURL : googleCalendarURL
//        
//        db.collection("users").document(userId).updateData([urlKey: urlValue]) { error in
//            if let error = error {
//                print("Error saving calendar URL: \(error.localizedDescription)")
//            } else {
//                print("Successfully saved \(isMoodle ? "Moodle" : "Google") Calendar URL")
//            }
//        }
//    }
//    
//    // Load URLs from Firestore
//    func loadCalendarURLs() {
//        guard let userId = Auth.auth().currentUser?.uid else { return }
//        
//        db.collection("users").document(userId).getDocument { document, error in
//            if let document = document, document.exists {
//                DispatchQueue.main.async {
//                    self.moodleCalendarURL = document["moodleCalendarURL"] as? String ?? ""
//                    self.googleCalendarURL = document["googleCalendarURL"] as? String ?? ""
//                }
//            }
//        }
//    }
//    
//    func loadEventsFromFirestore() {
//        guard let userId = Auth.auth().currentUser?.uid else { return }
//
//        db.collection("users").document(userId).collection("moodleEvents")
//            .getDocuments { snapshot, error in
//                if let error = error {
//                    print("Error loading events: \(error.localizedDescription)")
//                    return
//                }
//
//                if let documents = snapshot?.documents {
//                    DispatchQueue.main.async {
//                        self.moodleEvents = documents.compactMap { doc in
//                            let data = doc.data()
//                            return MoodleEvent(
//                                id: data["id"] as? String ?? UUID().uuidString,
//                                title: data["title"] as? String ?? "Unknown",
//                                startDate: data["startDate"] as? TimeInterval ?? 0,
//                                endDate: data["endDate"] as? TimeInterval ?? 0,
//                                description: data["description"] as? String ?? "No description",
//                                notifyBefore: data["notifyBefore"] as? TimeInterval
//                            )
//                        }
//                    }
//                }
//            }
//    }
//
//    // Parsing and Saving Moodle Events
//    func parseAndSaveMoodleCalendarData(_ icsString: String) {
//        let lines = icsString.components(separatedBy: "\n")
//        var event: [String: String] = [:]
//        var currentDescription = ""
//        var isCollectingDescription = false
//        var events: [MoodleEvent] = []
//
//        for line in lines {
//            if line.hasPrefix("BEGIN:VEVENT") {
//                event = [:]
//                currentDescription = ""
//                isCollectingDescription = false
//            } else if line.hasPrefix("END:VEVENT") {
//                if let id = event["UID"],
//                   let title = event["SUMMARY"],
//                   let startDateStr = event["DTSTART"],
//                   let endDateStr = event["DTEND"],
//                   let startDate = parseDate(startDateStr),
//                   let endDate = parseDate(endDateStr) {
//
//                    currentDescription = cleanDescription(currentDescription)
//
//                    let moodleEvent = MoodleEvent(
//                        id: id,
//                        title: title,
//                        startDate: startDate.timeIntervalSince1970,
//                        endDate: endDate.timeIntervalSince1970,
//                        description: currentDescription.isEmpty ? "No description" : currentDescription,
//                        notifyBefore: nil
//                    )
//
//                    events.append(moodleEvent)
//                }
//            } else {
//                let parts = line.split(separator: ":", maxSplits: 1)
//                if parts.count == 2 {
//                    let key = String(parts[0]).trimmingCharacters(in: .whitespaces)
//                    let value = String(parts[1]).trimmingCharacters(in: .whitespaces)
//
//                    if key == "DESCRIPTION" {
//                        currentDescription = value
//                        isCollectingDescription = true
//                    } else {
//                        event[key] = value
//                        isCollectingDescription = false
//                    }
//                } else if isCollectingDescription {
//                    currentDescription += " " + line.trimmingCharacters(in: .whitespaces)
//                }
//            }
//        }
//        
//        saveMoodleEventsToFirestore(events)
//    }
//
//    // Parsing and Saving Google Calendar Events
//    func parseAndSaveGoogleCalendarData(_ icsString: String) {
//        let lines = icsString.components(separatedBy: "\n")
//        var event: [String: String] = [:]
//        var currentDescription = ""
//        var isCollectingDescription = false
//        var events: [CalendarEvent] = []
//
//        for line in lines {
//            if line.hasPrefix("BEGIN:VEVENT") {
//                event = [:]
//                currentDescription = ""
//                isCollectingDescription = false
//            } else if line.hasPrefix("END:VEVENT") {
//                if let id = event["UID"],
//                   let title = event["SUMMARY"],
//                   let startDateStr = event["DTSTART"],
//                   let endDateStr = event["DTEND"],
//                   let startDate = parseDate(startDateStr),
//                   let endDate = parseDate(endDateStr) {
//
//                    currentDescription = cleanDescription(currentDescription)
//
//                    let calendarEvent = CalendarEvent(
//                        id: id,
//                        title: title,
//                        startDate: startDate.timeIntervalSince1970,
//                        endDate: endDate.timeIntervalSince1970,
//                        description: currentDescription.isEmpty ? "No description" : currentDescription
//                    )
//
//                    events.append(calendarEvent)
//                }
//            } else {
//                let parts = line.split(separator: ":", maxSplits: 1)
//                if parts.count == 2 {
//                    let key = String(parts[0]).trimmingCharacters(in: .whitespaces)
//                    let value = String(parts[1]).trimmingCharacters(in: .whitespaces)
//
//                    if key == "DESCRIPTION" {
//                        currentDescription = value
//                        isCollectingDescription = true
//                    } else {
//                        event[key] = value
//                        isCollectingDescription = false
//                    }
//                } else if isCollectingDescription {
//                    currentDescription += " " + line.trimmingCharacters(in: .whitespaces)
//                }
//            }
//        }
//        
//        saveGoogleEventsToFirestore(events)
//    }
//
//    // Save Moodle events to Firestore
//    private func saveMoodleEventsToFirestore(_ events: [MoodleEvent]) {
//        guard let userId = Auth.auth().currentUser?.uid else { return }
//        let userEventsRef = db.collection("users").document(userId).collection("moodleEvents")
//        
//        for event in events {
//            let eventData: [String: Any] = [
//                "id": event.id,
//                "title": event.title,
//                "startDate": event.startDate,
//                "endDate": event.endDate,
//                "description": event.description,
//                "notifyBefore": event.notifyBefore ?? 0
//            ]
//            
//            userEventsRef.document(event.id).setData(eventData)
//        }
//    }
//
//    // Save Google events to Firestore
//    private func saveGoogleEventsToFirestore(_ events: [CalendarEvent]) {
//        guard let userId = Auth.auth().currentUser?.uid else { return }
//        let userEventsRef = db.collection("users").document(userId).collection("googleEvents")
//        
//        for event in events {
//            let eventData: [String: Any] = [
//                "id": event.id,
//                "title": event.title,
//                "startDate": event.startDate,
//                "endDate": event.endDate,
//                "description": event.description
//            ]
//            
//            userEventsRef.document(event.id).setData(eventData)
//        }
//    }
//    
//    private func parseDate(_ dateString: String) -> Date? {
//        let isoFormatter = ISO8601DateFormatter()
//        isoFormatter.formatOptions = [.withYear, .withMonth, .withDay, .withTime, .withTimeZone]
//        return isoFormatter.date(from: dateString.trimmingCharacters(in: .whitespacesAndNewlines))
//    }
//    
//    // Function to clean description text
//    private func cleanDescription(_ description: String) -> String {
//        var cleanedDescription = description
//        cleanedDescription = cleanedDescription.replacingOccurrences(of: "\n", with: "")
//        cleanedDescription = cleanedDescription.replacingOccurrences(of: "\\n", with: "\n")
//        cleanedDescription = cleanedDescription.replacingOccurrences(of: "\\,", with: ",")
//        cleanedDescription = cleanedDescription.replacingOccurrences(of: "\\;", with: ";")
//        cleanedDescription = cleanedDescription.replacingOccurrences(of: "\\", with: "")
//        cleanedDescription = cleanedDescription.trimmingCharacters(in: .whitespacesAndNewlines)
//        return cleanedDescription
//    }
//}

