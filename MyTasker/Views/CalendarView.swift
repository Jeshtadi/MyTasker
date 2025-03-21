//
//
//// displays correctly
//import SwiftUI
//import FirebaseFirestore
//import FirebaseAuth
//import Foundation
//
//struct CalendarView: View {
//    @State private var selectedWeek: Date = Date()
//    @State private var selectedDate: Date = Date()
//    
//    @StateObject private var viewModel = CreateNewItemVM()  // Use the updated ViewModel
//    
//    private let calendar = Calendar.current
//    private let daysOfWeek: [String] = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
//
//    private var monthYearFormatter: DateFormatter {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "MMMM yyyy"
//        return formatter
//    }
//
//    func getStartOfWeek(for date: Date) -> Date {
//        let weekday = calendar.component(.weekday, from: date)
//        let daysToSubtract = (weekday + 5) % 7
//        return calendar.date(byAdding: .day, value: -daysToSubtract, to: date) ?? date
//    }
//
//    func getWeekDates(for date: Date) -> [Date] {
//        let startOfWeek = getStartOfWeek(for: date)
//        return (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: startOfWeek) }
//    }
//
//    func changeMonth(by value: Int) {
//        if let newMonth = calendar.date(byAdding: .month, value: value, to: selectedWeek) {
//            selectedWeek = newMonth
//        }
//    }
//
//    func changeYear(by value: Int) {
//        if let newYear = calendar.date(byAdding: .year, value: value, to: selectedWeek) {
//            selectedWeek = newYear
//        }
//    }
//
//    func loadData(for date: Date) {
//        // Fetch tasks and filter by the selected date's due date
//        viewModel.fetchTasks()  // Using the updated fetchTasks method from CreateNewItemVM
//    }
//
//    var body: some View {
//        VStack(spacing: 15) {
//            // Year Navigation
//            HStack {
//                Button(action: { changeYear(by: -1) }) {
//                    Image(systemName: "chevron.left.circle")
//                        .foregroundColor(ColorPalette.textPrimary)
//                        .padding()
//                }
//
//                // Month-Year Navigation (<< < March > >> style)
//                HStack(spacing: 5) {
//                    Button(action: { changeMonth(by: -1) }) {
//                        Image(systemName: "chevron.left")
//                            .foregroundColor(ColorPalette.textPrimary)
//                            .padding()
//                    }
//
//                    Text(monthYearFormatter.string(from: selectedWeek))
//                        .font(.title2)
//                        .bold()
//                        .foregroundColor(ColorPalette.textPrimary)
//                        .frame(width: 120, alignment: .center)
//
//                    Button(action: { changeMonth(by: 1) }) {
//                        Image(systemName: "chevron.right")
//                            .foregroundColor(ColorPalette.textPrimary)
//                            .padding()
//                    }
//                }
//
//                Button(action: { changeYear(by: 1) }) {
//                    Image(systemName: "chevron.right.circle")
//                        .foregroundColor(ColorPalette.textPrimary)
//                        .padding()
//                }
//            }
//
//            // Weekday Headers
//            HStack {
//                ForEach(daysOfWeek, id: \.self) { day in
//                    Text(day)
//                        .frame(maxWidth: .infinity)
//                        .font(.subheadline)
//                        .foregroundColor(ColorPalette.textPrimary)
//                }
//            }
//            .padding(.horizontal)
//
//            // Week Scrolling View
//            TabView(selection: $selectedWeek) {
//                ForEach(-5...5, id: \.self) { offset in
//                    let weekDate = calendar.date(byAdding: .weekOfYear, value: offset, to: selectedWeek) ?? selectedWeek
//                    VStack {
//                        HStack {
//                            ForEach(getWeekDates(for: weekDate), id: \.self) { date in
//                                Text("\(calendar.component(.day, from: date))")
//                                    .frame(maxWidth: .infinity)
//                                    .font(.body)
//                                    .padding(6)
//                                    .background(date == selectedDate ? ColorPalette.highlightColor : ColorPalette.cardBackground)
//                                    .cornerRadius(6)
//                                    .onTapGesture {
//                                        selectedDate = date
//                                        loadData(for: date)  // Load tasks for the selected date
//                                    }
//                            }
//                        }
//                        .padding(.horizontal)
//                    }
//                    .tag(weekDate)
//                }
//            }
//            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
//            .frame(height: 50)
//
//            // Display tasks for the selected date
//            if !viewModel.tasks.isEmpty {
//                VStack(alignment: .leading) {
//                    Text("Tasks for \(calendar.component(.day, from: selectedDate)) \(monthYearFormatter.string(from: selectedDate))")
//                        .font(.headline)
//                        .padding(.top)
//
//                    ForEach(viewModel.tasks.filter { task in
//                        let taskDueDate = Date(timeIntervalSince1970: task.dueDate)
//                        return calendar.isDate(taskDueDate, inSameDayAs: selectedDate)
//                    }) { task in
//                        VStack(alignment: .leading) {
//                            Text(task.title)
//                                .font(.subheadline)
//                                .bold()
//                            Text(task.description ?? "No description")
//                                .font(.body)
//                                .foregroundColor(.gray)
//                            Text("Due: \(DateFormatter.localizedString(from: Date(timeIntervalSince1970: task.dueDate), dateStyle: .short, timeStyle: .short))")
//                                .font(.body)
//                                .foregroundColor(.gray)
//                            Divider()
//                        }
//                        .padding(.vertical, 5)
//                    }
//                }
//                .padding(.horizontal)
//            }
//
//            Spacer()
//        }
//        .padding(.top, 25)
//        .background(ColorPalette.primaryBackground.edgesIgnoringSafeArea(.all))
//    }
//}
//
//#Preview {
//    CalendarView()
//}


// working and using code
//import SwiftUI
//import FirebaseFirestore
//import FirebaseAuth
//import Foundation
//
//struct CalendarView: View {
//    @State private var selectedWeek: Date = Date()
//    @State private var selectedDate: Date = Date()
//    
//    @StateObject private var viewModel = CreateNewItemVM()  // Use the updated ViewModel
//    
//    private let calendar = Calendar.current
//    private let daysOfWeek: [String] = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
//    
//    private var monthYearFormatter: DateFormatter {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "MMMM yyyy"
//        return formatter
//    }
//
//    func getStartOfWeek(for date: Date) -> Date {
//        let weekday = calendar.component(.weekday, from: date)
//        let daysToSubtract = (weekday + 5) % 7
//        return calendar.date(byAdding: .day, value: -daysToSubtract, to: date) ?? date
//    }
//
//    func getWeekDates(for date: Date) -> [Date] {
//        let startOfWeek = getStartOfWeek(for: date)
//        return (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: startOfWeek) }
//    }
//
//    func changeMonth(by value: Int) {
//        if let newMonth = calendar.date(byAdding: .month, value: value, to: selectedWeek) {
//            selectedWeek = newMonth
//        }
//    }
//
//    func changeYear(by value: Int) {
//        if let newYear = calendar.date(byAdding: .year, value: value, to: selectedWeek) {
//            selectedWeek = newYear
//        }
//    }
//
//    func loadData(for date: Date) {
//        viewModel.fetchTasks()  // Using the updated fetchTasks method from CreateNewItemVM
//    }
//
//    // Function to get all dates that have tasks
//    func getDatesWithTasks() -> [Date] {
//        let tasksWithDueDates = viewModel.tasks.filter { task in
//            let taskDueDate = Date(timeIntervalSince1970: task.dueDate)
//            return calendar.isDate(taskDueDate, equalTo: selectedWeek, toGranularity: .month)
//        }
//        
//        var datesWithTasks: [Date] = []
//        for task in tasksWithDueDates {
//            let taskDueDate = Date(timeIntervalSince1970: task.dueDate)
//            if !datesWithTasks.contains(where: { calendar.isDate($0, inSameDayAs: taskDueDate) }) {
//                datesWithTasks.append(taskDueDate)
//            }
//        }
//        return datesWithTasks
//    }
//    
//    func dateCell(for date: Date) -> some View {
//        VStack {
//            Text("\(calendar.component(.day, from: date))")
//                .frame(maxWidth: .infinity)
//                .font(.body)
//                .padding(6)
//                .background(
//                    calendar.isDate(date, inSameDayAs: Date()) ? ColorPalette.warningColor :  // Highlights the current date
//                    (date == selectedDate ? ColorPalette.highlightColor : ColorPalette.cardBackground)
//                )
//                .cornerRadius(6)
//                .onTapGesture {
//                    selectedDate = date
//                    loadData(for: date)
//                }
//
//            if getDatesWithTasks().contains(where: { calendar.isDate($0, inSameDayAs: date) }) {
//                Circle()
//                    .frame(width: 6, height: 6)
//                    .foregroundColor(ColorPalette.warningColor)
//                    .padding(.top, 4)
//            }
//        }
//    }
//
//
//    // Create separate function for the weekday header
//    func weekdayHeader() -> some View {
//        HStack {
//            ForEach(daysOfWeek, id: \.self) { day in
//                Text(day)
//                    .frame(maxWidth: .infinity)
//                    .font(.subheadline)
//                    .foregroundColor(ColorPalette.textPrimary)
//            }
//        }
//        .padding(.horizontal)
//    }
//
//    // Create separate function for navigation bar
//    func navigationBar() -> some View {
//        HStack {
//            Button(action: { changeYear(by: -1) }) {
//                Image(systemName: "chevron.left.circle")
//                    .foregroundColor(ColorPalette.textPrimary)
//                    .padding()
//            }
//
//            // Month-Year Navigation (<< < March > >> style)
//            HStack(spacing: 5) {
//                Button(action: { changeMonth(by: -1) }) {
//                    Image(systemName: "chevron.left")
//                        .foregroundColor(ColorPalette.textPrimary)
//                        .padding()
//                }
//
//                Text(monthYearFormatter.string(from: selectedWeek))
//                    .font(.title2)
//                    .bold()
//                    .foregroundColor(ColorPalette.textPrimary)
//                    .frame(width: 120, alignment: .center)
//
//                Button(action: { changeMonth(by: 1) }) {
//                    Image(systemName: "chevron.right")
//                        .foregroundColor(ColorPalette.textPrimary)
//                        .padding()
//                }
//            }
//
//            Button(action: { changeYear(by: 1) }) {
//                Image(systemName: "chevron.right.circle")
//                    .foregroundColor(ColorPalette.textPrimary)
//                    .padding()
//            }
//        }
//    }
//
//    // Create the Week Scrolling View as a subview
//    func weekScrollingView() -> some View {
//        TabView(selection: $selectedWeek) {
//            ForEach(-5...5, id: \.self) { offset in
//                let weekDate = calendar.date(byAdding: .weekOfYear, value: offset, to: selectedWeek) ?? selectedWeek
//                VStack {
//                    HStack {
//                        ForEach(getWeekDates(for: weekDate), id: \.self) { date in
//                            dateCell(for: date)  // Call the new dateCell function
//                        }
//                    }
//                    .padding(.horizontal)
//                }
//                .tag(weekDate)
//            }
//        }
//        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
//        .frame(height: 50)
//    }
//
//    var body: some View {
//        VStack(spacing: 15) {
//            navigationBar()
//
//            // Weekday Headers
//            weekdayHeader()
//
//            // Week Scrolling View
//            weekScrollingView()
//
//            // Display tasks for the selected date
//            if !viewModel.tasks.isEmpty {
//                VStack(alignment: .leading) {
//                    Text("Tasks for \(calendar.component(.day, from: selectedDate)) \(monthYearFormatter.string(from: selectedDate))")
//                        .font(.headline)
//                        .padding(.top)
//
//                    ForEach(viewModel.tasks.filter { task in
//                        let taskDueDate = Date(timeIntervalSince1970: task.dueDate)
//                        return calendar.isDate(taskDueDate, inSameDayAs: selectedDate)
//                    }) { task in
//                        VStack(alignment: .leading) {
//                            Text(task.title)
//                                .font(.subheadline)
//                                .bold()
//                            Text(task.description ?? "No description")
//                                .font(.body)
//                                .foregroundColor(.gray)
//                            Text("Due: \(DateFormatter.localizedString(from: Date(timeIntervalSince1970: task.dueDate), dateStyle: .short, timeStyle: .short))")
//                                .font(.body)
//                                .foregroundColor(.gray)
//                            Divider()
//                        }
//                        .padding(.vertical, 5)
//                    }
//                }
//                .padding(.horizontal)
//            }
//
//            Spacer()
//        }
//        .padding(.top, 25)
////        .background(ColorPalette.primaryBackground.edgesIgnoringSafeArea(.all))
//    }
//}
//
//#Preview {
//    CalendarView()
//}






//imported calender code
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

    
    @State private var selectedWeek: Date = Date()
    @State private var selectedDate: Date = Date()
    
    @StateObject private var viewModel = CreateNewItemVM()
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

    // Function to get all dates that have tasks or imported calendar events
    func getDatesWithTasks() -> [Date] {
        var datesWithTasks: Set<Date> = []
        
        // Add due dates from MyTasker tasks
        for task in viewModel.tasks {
            let taskDueDate = Date(timeIntervalSince1970: task.dueDate)
            if calendar.isDate(taskDueDate, equalTo: selectedWeek, toGranularity: .month) {
                datesWithTasks.insert(taskDueDate)
            }
        }

        // Add start dates from imported calendar events
        for event in importViewModel.events {
            let eventDate = Date(timeIntervalSince1970: event.startDate)
            if calendar.isDate(eventDate, equalTo: selectedWeek, toGranularity: .month) {
                datesWithTasks.insert(eventDate)
            }
        }
        
        return Array(datesWithTasks)
    }
    
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

    var body: some View {
        VStack(spacing: 15) {
            navigationBar()
            weekdayHeader()
            weekScrollingView()

            if !viewModel.tasks.isEmpty || !importViewModel.events.isEmpty {
                VStack(alignment: .leading) {
                    Text("Events & Tasks for \(calendar.component(.day, from: selectedDate)) \(monthYearFormatter.string(from: selectedDate))")
                        .font(.headline)
                        .padding(.top)

                    ForEach(viewModel.tasks.filter { task in
                        let taskDueDate = Date(timeIntervalSince1970: task.dueDate)
                        return calendar.isDate(taskDueDate, inSameDayAs: selectedDate)
                    }) { task in
                        VStack(alignment: .leading) {
                            Text(task.title)
                                .font(.subheadline)
                                .bold()
                            Text(task.description ?? "No description")
                                .font(.body)
                                .foregroundColor(.gray)
                            Text("Due: \(DateFormatter.localizedString(from: Date(timeIntervalSince1970: task.dueDate), dateStyle: .short, timeStyle: .short))")
                                .font(.body)
                                .foregroundColor(.gray)
                            Divider()
                        }
                        .padding(.vertical, 5)
                    }

                    ForEach(importViewModel.events.filter { event in
                        let eventStartDate = Date(timeIntervalSince1970: event.startDate)
                        return calendar.isDate(eventStartDate, inSameDayAs: selectedDate)
                    }) { event in
                        VStack(alignment: .leading) {
                            Text(event.title)
                                .font(.subheadline)
                                .bold()
                            Text(event.description)
                                .font(.body)
                                .foregroundColor(.gray)
                            Text("Starts: \(Date(timeIntervalSince1970: event.startDate), formatter: dateFormatter)")
                                .font(.body)
                                .foregroundColor(.gray)
                            Divider()
                        }
                        .padding(.vertical, 5)
                    }
                }
                .padding(.horizontal)
            }
            Spacer()
        }
        .padding(.top, 25)
    }
}

#Preview {
    CalendarView()
}


