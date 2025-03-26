//
//  Import.swift
//  MyTasker
//
//  Created by Anushya Jeshtadi on 23/02/2025.
//

//working
//import SwiftUI
//
//struct ImportCalendarView: View {
//    @State private var moodleURL: String = ""
//    @State private var events: [[String: String]] = [] // Store parsed events
//
//    var body: some View {
//        VStack {
//            TextField("Enter Moodle Calendar URL", text: $moodleURL)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//
//            Button("Import Calendar") {
//                fetchICSFile(from: moodleURL) { parsedEvents in
//                    self.events = parsedEvents // Update UI with parsed events
//                }
//            }
//            .buttonStyle(.bordered)
//
//            List(events, id: \.self) { event in
//                VStack(alignment: .leading) {
//                    Text(event["SUMMARY"] ?? "Unknown Event")
//                        .font(.headline)
//                    Text(event["DTSTART"] ?? "No Date")
//                        .font(.subheadline)
//                }
//            }
//        }
//        .padding()
//    }
//}
//
//
//import Foundation
//
//func fetchICSFile(from urlString: String, completion: @escaping ([[String: String]]) -> Void) {
//    guard let url = URL(string: urlString) else {
//        print("Invalid URL")
//        return
//    }
//
//    let task = URLSession.shared.dataTask(with: url) { data, response, error in
//        if let error = error {
//            print("Error fetching .ics file: \(error)")
//            return
//        }
//
//        if let data = data, let icsString = String(data: data, encoding: .utf8) {
//            let parsedEvents = parseICS(icsString)
//            DispatchQueue.main.async {
//                completion(parsedEvents) // Pass parsed events to UI
//            }
//        }
//    }
//    task.resume()
//}
//
//func parseICS(_ icsString: String) -> [[String: String]] {
//    let lines = icsString.components(separatedBy: "\n")
//    var event: [String: String] = [:]
//    var events: [[String: String]] = []
//
//    for line in lines {
//        if line.hasPrefix("BEGIN:VEVENT") {
//            event = [:] // Start new event
//        } else if line.hasPrefix("END:VEVENT") {
//            if let startDate = event["DTSTART"] {
//                event["FormattedDate"] = formatDate(startDate)
//            }
//            events.append(event) // Save event
//        } else {
//            let parts = line.split(separator: ":", maxSplits: 1)
//            if parts.count == 2 {
//                let key = String(parts[0]).trimmingCharacters(in: .whitespaces)
//                let value = String(parts[1]).trimmingCharacters(in: .whitespaces)
//                event[key] = value
//            }
//        }
//    }
//
//    return events // Return parsed events
//}
//
//func formatDate(_ dateString: String) -> String {
//    let dateFormatter = DateFormatter()
//    dateFormatter.dateFormat = "yyyyMMdd'T'HHmmss'Z'"
//    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
//
//    if let date = dateFormatter.date(from: dateString) {
//        let outputFormatter = DateFormatter()
//        outputFormatter.dateFormat = "EEEE, d MMM yyyy h:mm a"
//        outputFormatter.timeZone = TimeZone.current // Convert to local time
//        return outputFormatter.string(from: date)
//    } else {
//        return "Invalid Date"
//    }
//}





//final working for moodle
//import SwiftUI
////
//struct ImportCalendarView: View {
//    @StateObject private var viewModel = ImportCalendarViewModel()
//
//    var body: some View {
//        VStack {
//            TextField("Enter Moodle Calendar URL", text: $viewModel.moodleURL)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//
//            Button(action: {
//                viewModel.importCalendar()
//            }) {
//                Text("Import Calendar")
//                    .font(.headline)
//                    .padding()
//                    .frame(maxWidth: .infinity)
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            }
//            .padding()
//
//            List(viewModel.events, id: \.id) { event in
//                VStack(alignment: .leading) {
//                    Text(event.title)
//                        .font(.headline)
//
//                    // Convert NSAttributedString to a plain String with formatting preserved
//                    Text(event.attributedDescription().string.isEmpty ? "No description available" : event.attributedDescription().string)
//                        .font(.subheadline)
//                        .foregroundColor(.gray)
//                        .lineLimit(nil)
//                        .fixedSize(horizontal: false, vertical: true)
//                        .padding(.bottom, 8)
//
//                    Text("Start: \(Date(timeIntervalSince1970: event.startDate), formatter: dateFormatter)")
//                        .font(.caption)
//                    Text("End: \(Date(timeIntervalSince1970: event.endDate), formatter: dateFormatter)")
//                        .font(.caption)
//                }
//            }
//        }
//        .padding()
//    }
//}
//
//// Date formatter for SwiftUI display
//private let dateFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateStyle = .medium
//    formatter.timeStyle = .short
//    return formatter
//}()




import SwiftUI

struct ImportCalendarView: View {
    @StateObject private var viewModel = ImportCalendarViewModel()
    @State private var errorMessage: String?
    @State private var showInstructions = false
    @State private var showAlert = false
    @State private var alertMessage: String = ""
    @State private var refreshView = false
    @State private var navigateToCalendar = false // Track navigation state
    @State private var showNavigationPrompt = false // Prompt user after import

    var body: some View {
        NavigationView {
            ZStack {
                ColorPalette.primaryBackground
                    .edgesIgnoringSafeArea(.all)

                VStack(alignment: .leading, spacing: 16) {
                    Text("Import Your Moodle Calendar")
                        .font(.title2)
                        .padding(.bottom)
                        .fontWeight(.bold)
                        .foregroundColor(ColorPalette.textPrimary)

                    Text("Enter your Moodle Calendar URL below to sync with MyTasker.")
                        .foregroundColor(ColorPalette.textPrimary)

                    TextField("Enter Moodle Calendar URL", text: $viewModel.moodleURL)
                        .padding()
                        .background(ColorPalette.cardBackground)
                        .cornerRadius(8)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(ColorPalette.borderColor, lineWidth: 1))

                    if let error = errorMessage {
                        Text(error)
                            .foregroundColor(ColorPalette.errorColor)
                    }

                    Button(action: {
                        if viewModel.moodleURL.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            alertMessage = "Please enter a valid Moodle Calendar URL."
                            showAlert = true
                        } else {
                            viewModel.importCalendar { error in
                                if let error = error {
                                    alertMessage = error
                                    showAlert = true
                                } else {
                                    alertMessage = "Calendar successfully added to your app!"
                                    showNavigationPrompt = true // Show prompt after success

                                    // ✅ Load events immediately, regardless of user choice
                                    DispatchQueue.main.async {
                                        viewModel.loadEventsFromFirestore()
                                    }
                                }
                                showAlert = true
                                refreshView.toggle() // Force UI refresh
                            }
                        }
                    }) {
                        Text("Import Calendar")
                            .fontWeight(.bold)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(ColorPalette.buttonBackground)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .onChange(of: refreshView) { _ in
                        viewModel.loadEventsFromFirestore()
                    }

                    Button("How to Find Your Moodle Calendar URL?") {
                        showInstructions.toggle()
                    }
                    .padding()
                    .foregroundColor(ColorPalette.accentColor)
                    .sheet(isPresented: $showInstructions) {
                        MoodleInstructionsView()
                    }

                    // Navigation link to CalendarView (hidden but activated when navigateToCalendar is true)
                    NavigationLink(destination: CalendarView(), isActive: $navigateToCalendar) {
                        EmptyView()
                    }
                }
                .padding()
            }
            .alert(isPresented: $showAlert) {
                return Alert(
                    title: Text("Calendar Imported"),
                    message: Text("Your Moodle events have been successfully added."),
                    dismissButton: .default(Text("Confirm")) {
                        navigateToCalendar = true
                    }
                )
            }

        }
    }
}


struct MoodleInstructionsView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            ColorPalette.primaryBackground // Ensures full-screen background color
                .edgesIgnoringSafeArea(.all)

            VStack(alignment: .leading, spacing: 10) {
                Text("How to Find Your Moodle Calendar URL?")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(ColorPalette.textPrimary)

                Text("1. Open Moodle and go to your calendar.")
                    .foregroundColor(ColorPalette.textPrimary)
                Text("2. Click on ‘Export calendar’.")
                    .foregroundColor(ColorPalette.textPrimary)
                Text("3. Select ‘All events’ or ‘Custom range’.")
                    .foregroundColor(ColorPalette.textPrimary)
                Text("4. Copy the provided URL and paste it here.")
                    .foregroundColor(ColorPalette.textPrimary)

                Button("Close") {
                    presentationMode.wrappedValue.dismiss()
                }
                .padding()
                .background(ColorPalette.buttonBackground)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            .padding()
            .background(ColorPalette.secondaryBackground)
            .cornerRadius(12)
            .shadow(color: ColorPalette.shadowColor, radius: 4, x: 0, y: 2)
            .padding()
        }
    }
}









//
//trying for google calendar
//import SwiftUI
//
//struct ImportCalendarView: View {
//    @ObservedObject var viewModel = ImportCalendarViewModel()
//    @State private var selectedCalendar: String = "Moodle"  // Default to Moodle
//    @State private var showAlert = false
//    @State private var alertMessage = ""
//
//    var body: some View {
//        VStack {
//            Picker("Select Calendar", selection: $selectedCalendar) {
//                Text("Moodle").tag("Moodle")
//                Text("Google").tag("Google")
//            }
//            .pickerStyle(SegmentedPickerStyle())
//            .padding()
//
//            TextField("Enter Calendar URL", text: selectedCalendar == "Moodle" ? $viewModel.moodleCalendarURL : $viewModel.googleCalendarURL)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//
//            Button(action: {
//                if selectedCalendar == "Moodle" {
//                    viewModel.saveCalendarURL(isMoodle: true)
//                    alertMessage = "Moodle Calendar URL saved successfully."
//                } else {
//                    viewModel.saveCalendarURL(isMoodle: false)
//                    alertMessage = "Google Calendar URL saved successfully."
//                }
//                showAlert = true
//            }) {
//                Text("Save URL")
//                    .padding()
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(8)
//            }
//
//            Divider()
//                .padding()
//
//            Text("Events:")
//                .font(.headline)
//
//            List {
//                ForEach(viewModel.moodleEvents, id: \.id) { event in
//                    VStack(alignment: .leading) {
//                        Text(event.title)
//                            .fontWeight(.bold)
//                        Text(event.description)
//                            .font(.subheadline)
//                    }
//                    .padding(.bottom, 5)
//                }
//                
//                ForEach(viewModel.googleEvents, id: \.id) { event in
//                    VStack(alignment: .leading) {
//                        Text(event.title)
//                            .fontWeight(.bold)
//                        Text(event.description)
//                            .font(.subheadline)
//                    }
//                    .padding(.bottom, 5)
//                }
//            }
//            .onAppear {
//                viewModel.loadEventsFromFirestore()
//            }
//        }
//        .padding()
//        .alert(isPresented: $showAlert) {
//            Alert(title: Text("Success"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
//        }
//    }
//}
//
//struct ImportCalendarView_Previews: PreviewProvider {
//    static var previews: some View {
//        ImportCalendarView()
//    }
//}
