


import SwiftUI
import FirebaseFirestore
import FirebaseAuth
import Foundation

struct CalendarView: View {
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    
    //    @ObservedObject var toDoListItemsVM = ToDoListItemsVM() // ViewModel for updating task
    
    @State private var selectedWeek: Date = Date()
    @State private var selectedDate: Date = Date()
    
    @StateObject private var viewModel = CreateNewItemVM()
    @StateObject var ToDoListItem = ToDoListItemsVM()
    @StateObject private var importViewModel = ImportCalendarViewModel()  // Import ViewModel
    
    private let calendar = Calendar.current
    private let daysOfWeek: [String] = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    
    private var monthYearFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }
    
    func getStartOfWeek(for date: Date) -> Date {
        let weekday = calendar.component(.weekday, from: date)
        let daysToSubtract = (weekday + 5) % 7
        return calendar.date(byAdding: .day, value: -daysToSubtract, to: date) ?? date
    }
    
    func getWeekDates(for date: Date) -> [Date] {
        let startOfWeek = getStartOfWeek(for: date)
        return (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: startOfWeek) }
    }
    
    func changeMonth(by value: Int) {
        if let newMonth = calendar.date(byAdding: .month, value: value, to: selectedWeek) {
            selectedWeek = newMonth
        }
    }
    
    func changeYear(by value: Int) {
        if let newYear = calendar.date(byAdding: .year, value: value, to: selectedWeek) {
            selectedWeek = newYear
        }
    }
    
    func loadData(for date: Date) {
        viewModel.fetchTasks()
    }
    
    func getDatesWithTasks() -> [Date] {
        var datesWithTasks: Set<Date> = []
        
        let visibleDates = getWeekDates(for: selectedWeek)
        
        for task in viewModel.tasks {
            let taskDueDate = Date(timeIntervalSince1970: task.dueDate)
            if visibleDates.contains(where: { calendar.isDate($0, inSameDayAs: taskDueDate) }) {
                datesWithTasks.insert(taskDueDate)
            }
        }
        
        for event in importViewModel.events {
            let eventDate = Date(timeIntervalSince1970: event.startDate)
            if visibleDates.contains(where: { calendar.isDate($0, inSameDayAs: eventDate) }) {
                datesWithTasks.insert(eventDate)
            }
        }
        
        return Array(datesWithTasks)
    }
    
    //OLD GET DATES
    //    func getDatesWithTasks() -> [Date] {
    //        var datesWithTasks: Set<Date> = []
    //
    //
    //        for task in viewModel.tasks {
    //            let taskDueDate = Date(timeIntervalSince1970: task.dueDate)
    //            if calendar.isDate(taskDueDate, equalTo: selectedWeek, toGranularity: .month) {
    //                datesWithTasks.insert(taskDueDate)
    //            }
    //        }
    //
    //        for event in importViewModel.events {
    //            let eventDate = Date(timeIntervalSince1970: event.startDate)
    //            if calendar.isDate(eventDate, equalTo: selectedWeek, toGranularity: .month) {
    //                datesWithTasks.insert(eventDate)
    //            }
    //        }
    //
    //        return Array(datesWithTasks)
    //    }
    
    //    func toggleTaskCompletion(task: ToDoListitem) {
    //        let db = Firestore.firestore()
    //        let taskRef = db.collection("users/\(Auth.auth().currentUser?.uid ?? "")/todos").document(task.id)
    //
    //        let newStatus = !task.isDone
    //
    //        taskRef.updateData(["isDone": newStatus]) { error in
    //            if let error = error {
    //                print("Error updating task: \(error.localizedDescription)")
    //            } else {
    //                print("Task updated successfully!")
    //
    //                // Update the local task list
    //                if let index = viewModel.tasks.firstIndex(where: { $0.id == task.id }) {
    //                    viewModel.tasks[index].isDone = newStatus
    //                }
    //            }
    //        }
    //    }
    
    
    //    func toggleTaskCompletion(task: ToDoListitem) {
    //            // Toggle the task's completion status in Firestore
    //            let db = Firestore.firestore()
    //            let taskRef = db.collection("users/\(Auth.auth().currentUser?.uid ?? "")/todos").document(task.id)
    //
    //            // Update the task's completion status
    //            taskRef.updateData([
    //                "isDone": !task.isDone
    //            ]) { error in
    //                if let error = error {
    //                    print("Error updating task: \(error.localizedDescription)")
    //                } else {
    //                    print("Task updated successfully!")
    //                }
    //            }
    //        }
    
    func dateCell(for date: Date) -> some View {
        VStack {
            ZStack {
                // Your date text and background
                Text("\(calendar.component(.day, from: date))")
                    .frame(maxWidth: .infinity)
                    .font(.body)
                    .padding(6)
                    .background(
                        calendar.isDate(date, inSameDayAs: Date()) ? ColorPalette.accentColor :
                            (date == selectedDate ? ColorPalette.highlightColor : ColorPalette.cardBackground)
                    )
                    .cornerRadius(6)
                    .onTapGesture {
                        selectedDate = date
                        loadData(for: date)
                    }
                
                // Circle for tasks, placed below the date text
                if getDatesWithTasks().contains(where: { calendar.isDate($0, inSameDayAs: date) }) {
                    Circle()
                        .frame(width: 6, height: 6) // Adjust the circle size
                        .foregroundColor(ColorPalette.warningColor)
                        .offset(y: 20) // Position the circle below the date
                }
            }
        }
    }
    
    
    func weekdayHeader() -> some View {
        HStack {
            ForEach(daysOfWeek, id: \.self) { day in
                Text(day)
                    .frame(maxWidth: .infinity)
                    .font(.subheadline)
                    .foregroundColor(ColorPalette.textPrimary)
            }
        }
        .padding(.horizontal)
    }
    
    func navigationBar() -> some View {
        HStack {
            Button(action: { changeYear(by: -1) }) {
                Image(systemName: "chevron.left.circle")
                    .foregroundColor(ColorPalette.textPrimary)
                    .padding()
            }
            
            HStack(spacing: 5) {
                Button(action: { changeMonth(by: -1) }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(ColorPalette.textPrimary)
                        .padding()
                }
                
                Text(monthYearFormatter.string(from: selectedWeek))
                    .font(.title2)
                    .bold()
                    .foregroundColor(ColorPalette.textPrimary)
                    .frame(width: 120, alignment: .center)
                
                Button(action: { changeMonth(by: 1) }) {
                    Image(systemName: "chevron.right")
                        .foregroundColor(ColorPalette.textPrimary)
                        .padding()
                }
            }
            
            Button(action: { changeYear(by: 1) }) {
                Image(systemName: "chevron.right.circle")
                    .foregroundColor(ColorPalette.textPrimary)
                    .padding()
            }
        }
    }
    
    func weekScrollingView() -> some View {
        TabView(selection: $selectedWeek) {
            ForEach(-5...5, id: \.self) { offset in
                let weekDate = calendar.date(byAdding: .weekOfYear, value: offset, to: selectedWeek) ?? selectedWeek
                VStack {
                    HStack {
                        ForEach(getWeekDates(for: weekDate), id: \.self) { date in
                            dateCell(for: date)
                        }
                    }
                    .padding(.horizontal)
                }
                .tag(weekDate)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .frame(height: 50)
    }
    
    
    //working and using
    var body: some View {
        VStack(spacing: 15) {
            navigationBar()
                .zIndex(1)
            weekdayHeader()
            weekScrollingView()
            
            if !viewModel.tasks.isEmpty || !importViewModel.events.isEmpty {
                VStack(alignment: .leading) {
                    Text("Events & Tasks for \(calendar.component(.day, from: selectedDate)) \(monthYearFormatter.string(from: selectedDate))")
                        .font(.headline)
                        .padding(.top, 10)
                    
                    ScrollView {
                        VStack(spacing: 10) {
                            
                            ForEach(viewModel.tasks.filter { task in
                                let taskDueDate = Date(timeIntervalSince1970: task.dueDate)
                                return calendar.isDate(taskDueDate, inSameDayAs: selectedDate)
                            }) { task in
                                ToDoListitems(viewModel: ToDoListItem, item: task)
                            }
                            
                            
                            ForEach(importViewModel.events.filter { event in
                                let eventStartDate = Date(timeIntervalSince1970: event.startDate)
                                return calendar.isDate(eventStartDate, inSameDayAs: selectedDate)
                            }) { event in
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(event.title)
                                        .font(.subheadline)
                                        .bold()
                                    Text(event.description)
                                        .font(.body)
                                        .foregroundColor(.pink)
                                    Text("Starts: \(Date(timeIntervalSince1970: event.startDate), formatter: dateFormatter)")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    Divider()
                                }
                                .padding(.vertical, 5)
                                
                            }
                        }
                        .padding(.top,10)
                        
                    }
                }
                .padding(.horizontal)
            }
            Spacer()
            
        }
        .padding(.top, 20)
        
    }
}

#Preview {
    CalendarView()
}
