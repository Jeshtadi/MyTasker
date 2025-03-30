//
//  ToDoListitems.swift
//  MyTasker
//
//  Created by Anushya Jeshtadi on 22/01/2025.




//like working
//import SwiftUI
//
//struct ToDoListitems: View {
//    @StateObject var viewModel = ToDoListItemsVM()
//    let item: ToDoListitem
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8) {
//            // Title (Bold and Larger)
//            Text(item.title)
//                .font(.headline)
//                .bold()
//                .foregroundColor(.black)
//            
//            // Description
//            Text(item.description ?? "No description available")
//                .font(.subheadline)
//                .foregroundColor(.black.opacity(0.8))
//            
//            Divider()
//                .background(Color.black.opacity(0.5))
//            
//            // Additional Task Info
//            VStack(alignment: .leading, spacing: 5) {
//                Text("Due: \(Date(timeIntervalSince1970: item.dueDate).formatted(date: .abbreviated, time: .shortened))")
//                
//                Text("Created: \(Date(timeIntervalSince1970: item.createDate).formatted(date: .abbreviated, time: .shortened))")
//                
//                if let durationInSeconds = item.duration {
//                    let hours = Int(durationInSeconds) / 60
//                    let minutes = (Int(durationInSeconds) % 60)
//                    
//                    if hours > 0 {
//                        Text("Duration: \(hours) hour\(hours > 1 ? "s" : "") \(minutes > 0 ? "\(Int(minutes)) minute\(minutes > 1 ? "s" : "")" : "")")
//                        } else {
//                            Text("Duration: \(Int(minutes)) minute\(minutes > 1 ? "s" : "")")
//                        }
//                    }
//
//            
//                if let notifyBefore = item.notifyBefore {
//                    let minutes = Int(notifyBefore) / 60  // Convert from seconds to minutes
//                        
//                    if minutes < 60 {
//                        Text("Notify Before: \(minutes) minute\(minutes > 1 ? "s" : "")")  // Handle plural
//                    } else {
//                        let hours = minutes / 60
//                        Text("Notify Before: \(hours) hour\(hours > 1 ? "s" : "")")  // Handle plural
//                    }
//                }
//                    
//                if let repeatInterval = item.repeatInterval, repeatInterval > 0 {
//                    let intervalInDays = Int(repeatInterval) / 86400  // Convert seconds to days
//                    
//                    let weeks = intervalInDays / 7
//                    let months = intervalInDays / 30
//                    
//                    if months > 0 {
//                        Text("Notify Every: \(months) month\(months > 1 ? "s" : "")")
//                    } else if weeks > 0 {
//                        Text("Notify Every: \(weeks) week\(weeks > 1 ? "s" : "")")
//                    } else {
//                        Text("Notify Every: \(intervalInDays) day\(intervalInDays > 1 ? "s" : "")")
//                    }
//                }
//            }
//            .font(.footnote)
//            .foregroundColor(.black.opacity(0.9))
//            
//            // CEHCK MARK ON THE TASKS
//            HStack {
//                Spacer()
//                Button {
//                    // Toggle the task's 'isDone' status only when this button is pressed
//                    viewModel.toggleIsDone(item: item)
//                } label: {
//                    // The image changes based on the task's 'isDone' status
//                    Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
//                        .foregroundColor(.black)
//                        .font(.title2)
//                }
//            }
//            
//        
//
//        }
//        .padding()
//        .frame(maxWidth: .infinity, alignment: .leading)
//        .background(
//            RoundedRectangle(cornerRadius: 10)
//                .fill(viewModel.getTaskColor(for: item.color))
//        )
//        .padding(.horizontal)
//    }
//}
//
//extension ToDoListItemsVM {
//    func getTaskColor(for colorName: String?) -> Color {
//        switch colorName {
//        case "Red": return .red
//        case "Blue": return .blue
//        case "Green": return .green
//        case "Yellow": return .yellow
//        default: return .gray // Default color
//        }
//    }
//}
//
//#Preview {
//    ToDoListitems(item: .init(
//        id: "123",
//        title: "Get milk",
//        description: "Buy 2 liters of milk",
//        dueDate: Date().timeIntervalSince1970,
//        createDate: Date().timeIntervalSince1970,
//        duration: 3600,
//        isDone: false,
//        color: "Blue",
//        repeatInterval: 86400, // 1 day
//        notifyBefore: 1800 // 30 minutes
//    ))
//}
//

//
//import SwiftUI
//
//struct ToDoListitems: View {
//    @StateObject var viewModel = ToDoListItemsVM()
//    let item: ToDoListitem
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8) {
//            // Title (Bold and Larger)
//            Text(item.title)
//                .font(.headline)
//                .bold()
//                .foregroundColor(.black)
//            
//            // Description
//            Text(item.description ?? "No description available")
//                .font(.subheadline)
//                .foregroundColor(.black.opacity(0.8))
//            
//            Divider()
//                .background(Color.black.opacity(0.5))
//            
//            // Additional Task Info
//            VStack(alignment: .leading, spacing: 5) {
//                Text("Due: \(Date(timeIntervalSince1970: item.dueDate).formatted(date: .abbreviated, time: .shortened))")
//                
//                Text("Created: \(Date(timeIntervalSince1970: item.createDate).formatted(date: .abbreviated, time: .shortened))")
//                
//                if let durationInSeconds = item.duration {
//                    let hours = Int(durationInSeconds) / 60
//                    let minutes = (Int(durationInSeconds) % 60)
//                    
//                    if hours > 0 {
//                        Text("Duration: \(hours) hour\(hours > 1 ? "s" : "") \(minutes > 0 ? "\(Int(minutes)) minute\(minutes > 1 ? "s" : "")" : "")")
//                    } else {
//                        Text("Duration: \(Int(minutes)) minute\(minutes > 1 ? "s" : "")")
//                    }
//                }
//            
//                if let notifyBefore = item.notifyBefore {
//                    let minutes = Int(notifyBefore) / 60  // Convert from seconds to minutes
//                        
//                    if minutes < 60 {
//                        Text("Notify Before: \(minutes) minute\(minutes > 1 ? "s" : "")")  // Handle plural
//                    } else {
//                        let hours = minutes / 60
//                        Text("Notify Before: \(hours) hour\(hours > 1 ? "s" : "")")  // Handle plural
//                    }
//                }
//                    
//                if let repeatInterval = item.repeatInterval, repeatInterval > 0 {
//                    let intervalInDays = Int(repeatInterval) / 86400  // Convert seconds to days
//                    
//                    let weeks = intervalInDays / 7
//                    let months = intervalInDays / 30
//                    
//                    if months > 0 {
//                        Text("Notify Every: \(months) month\(months > 1 ? "s" : "")")
//                    } else if weeks > 0 {
//                        Text("Notify Every: \(weeks) week\(weeks > 1 ? "s" : "")")
//                    } else {
//                        Text("Notify Every: \(intervalInDays) day\(intervalInDays > 1 ? "s" : "")")
//                    }
//                }
//            }
//            .font(.footnote)
//            .foregroundColor(.black.opacity(0.9))
//            
//            // CHECK MARK ON THE TASKS
//            HStack {
//                Spacer()
//                Button {
//                    // Toggle the task's 'isDone' status only when this button is pressed
//                    viewModel.toggleIsDone(item: item)
//                } label: {
//                    // The image changes based on the task's 'isDone' status
//                    Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
//                        .foregroundColor(.black)
//                        .font(.title2)
//                }
//                .padding(10)
//                .contentShape(Rectangle()) // Ensure the button area is tappable
//            }
//        }
//        .padding()
//        .frame(maxWidth: .infinity, alignment: .leading)
//        .background(
//            RoundedRectangle(cornerRadius: 10)
//                .fill(viewModel.getTaskColor(for: item.color))
//        )
//        .padding(.horizontal)
//    }
//}
//
//extension ToDoListItemsVM {
//    func getTaskColor(for colorName: String?) -> Color {
//        switch colorName {
//        case "Red": return .red
//        case "Blue": return .blue
//        case "Green": return .green
//        case "Yellow": return .yellow
//        default: return .gray // Default color
//        }
//    }
//}
//
//
//import SwiftUI
//
//struct ToDoListitems: View {
//    @StateObject var viewModel = ToDoListItemsVM()
//    let item: ToDoListitem
//    @State private var showAlert = false
//    @AppStorage("hideCheckmarkMessage") private var hideCheckmarkMessage = false
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8) {
//            // Title (Bold and Larger)
//            Text(item.title)
//                .font(.headline)
//                .bold()
//                .foregroundColor(.black)
//            
//            // Description
//            Text(item.description ?? "No description available")
//                .font(.subheadline)
//                .foregroundColor(.black.opacity(0.8))
//            
//            Divider()
//                .background(Color.black.opacity(0.5))
//            
//            // Additional Task Info
//            VStack(alignment: .leading, spacing: 5) {
//                Text("Due: \(Date(timeIntervalSince1970: item.dueDate).formatted(date: .abbreviated, time: .shortened))")
//                
//                Text("Created: \(Date(timeIntervalSince1970: item.createDate).formatted(date: .abbreviated, time: .shortened))")
//                
//                if let durationInSeconds = item.duration {
//                    let hours = Int(durationInSeconds) / 60
//                    let minutes = (Int(durationInSeconds) % 60)
//                    
//                    if hours > 0 {
//                        Text("Duration: \(hours) hour\(hours > 1 ? "s" : "") \(minutes > 0 ? "\(Int(minutes)) minute\(minutes > 1 ? "s" : "")" : "")")
//                    } else {
//                        Text("Duration: \(Int(minutes)) minute\(minutes > 1 ? "s" : "")")
//                    }
//                }
//
//                if let notifyBefore = item.notifyBefore {
//                    let minutes = Int(notifyBefore) / 60  // Convert from seconds to minutes
//                    
//                    if minutes < 60 {
//                        Text("Notify Before: \(minutes) minute\(minutes > 1 ? "s" : "")")  // Handle plural
//                    } else {
//                        let hours = minutes / 60
//                        Text("Notify Before: \(hours) hour\(hours > 1 ? "s" : "")")  // Handle plural
//                    }
//                }
//                
//                if let repeatInterval = item.repeatInterval, repeatInterval > 0 {
//                    let intervalInDays = Int(repeatInterval) / 86400  // Convert seconds to days
//                    
//                    let weeks = intervalInDays / 7
//                    let months = intervalInDays / 30
//                    
//                    if months > 0 {
//                        Text("Notify Every: \(months) month\(months > 1 ? "s" : "")")
//                    } else if weeks > 0 {
//                        Text("Notify Every: \(weeks) week\(weeks > 1 ? "s" : "")")
//                    } else {
//                        Text("Notify Every: \(intervalInDays) day\(intervalInDays > 1 ? "s" : "")")
//                    }
//                }
//            }
//            .font(.footnote)
//            .foregroundColor(.black.opacity(0.9))
//            
//            // CHECK MARK & EDIT BUTTON
//            HStack {
//                Spacer()
//                // Check Mark Button
//                Button(action: {
//                    viewModel.toggleIsDone(item: item)
//                    if !hideCheckmarkMessage {
//                        showAlert = true
//                    }
//                }) {
//                    Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
//                        .foregroundColor(.black)
//                        .font(.title2)
//                }
//                .buttonStyle(PlainButtonStyle())
//                
//                // Edit Button
//                Button(action: {
//                    viewModel.editTask(item: item)
//                }) {
//                    Image(systemName: "pencil.circle")
//                        .foregroundColor(.black)
//                        .font(.title2)
//                }
//                .buttonStyle(PlainButtonStyle())
//            }
//        }
//        .padding()
//        .frame(maxWidth: .infinity, alignment: .leading)
//        .background(
//            RoundedRectangle(cornerRadius: 10)
//                .fill(viewModel.getTaskColor(for: item.color))
//        )
//        .padding(.horizontal)
//        .contentShape(Rectangle())
//        
//        .alert(isPresented: $showAlert) {
//            Alert(
//                title: Text("Task Completed"),
//                message: Text("You can find your finished tasks in the Done section."),
//                primaryButton: .default(Text("OK")),
//                secondaryButton: .destructive(Text("Don't show this message again")) {
//                    hideCheckmarkMessage = true
//                }
//            )
//        }
//    }
//}
//
//// Extend ViewModel to Handle Task Colors
//extension ToDoListItemsVM {
//    func getTaskColor(for colorName: String?) -> Color {
//        switch colorName {
//        case "Red": return .red
//        case "Blue": return .blue
//        case "Green": return .green
//        case "Yellow": return .yellow
//        default: return .gray // Default color
//        }
//    }
//    
//    // Function to Handle Task Editing
//    func editTask(item: ToDoListitem) {
//        // Implement navigation to edit screen or modify data as needed
//        print("Editing task: \(item.title)")
//    }
//}




import SwiftUI
import FirebaseFirestore


//uising todolist
struct ToDoListitems: View {
    @ObservedObject var viewModel: ToDoListItemsVM
    let item: ToDoListitem
    @State private var showAlert = false
    @State private var isEditing = false
    @AppStorage("hideCheckmarkMessage") private var hideCheckmarkMessage = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Title
            Text(item.title)
                .font(.headline)
                .bold()
                .foregroundColor(.black)
            
            // Description
            Text(item.description ?? "No description available")
                .font(.subheadline)
                .foregroundColor(.black.opacity(0.8))
            
            Divider()
                .background(Color.black.opacity(0.5))
            
            // Additional Task Info
            VStack(alignment: .leading, spacing: 5) {
                Text("Due: \(Date(timeIntervalSince1970: item.dueDate).formatted(date: .abbreviated, time: .shortened))")
                    .font(.system(size: 16))
                
                Text("Created: \(Date(timeIntervalSince1970: item.createDate).formatted(date: .abbreviated, time: .shortened))")
                
//                if let durationInSeconds = item.duration {
//                    let hours = Int(durationInSeconds) / 60
//                    let minutes = (Int(durationInSeconds) % 60)
//                    
//                    if hours > 0 {
//                        Text("Duration: \(hours) hour\(hours > 1 ? "s" : "") \(minutes > 0 ? "\(Int(minutes)) minute\(minutes > 1 ? "s" : "")" : "")")
//                    } else {
//                        Text("Duration: \(Int(minutes)) minute\(minutes > 1 ? "s" : "")")
//                    }
//                }
            }
            .font(.footnote)
            .foregroundColor(.black.opacity(0.9))
            
            HStack {
                Spacer()
                
                // Check Mark Button
                Button(action: {
                    let wasDone = item.isDone // Store previous state
                    viewModel.toggleIsDone(item: item)
                    
                    if !wasDone && !hideCheckmarkMessage {
                        showAlert = true
                    }
                }) {
                    Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(.black)
                        .font(.title2)
                }
                .buttonStyle(PlainButtonStyle())
                
                // Edit Button
                Button(action: {
                    isEditing = true
                }) {
                    Image(systemName: "pencil.circle")
                        .foregroundColor(.black)
                        .font(.title2)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(viewModel.getTaskColor(for: item.color))
        )
        .padding(.horizontal)
        .contentShape(Rectangle())
        
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Task Completed"),
                message: Text("You can find your finished tasks in the Done section."),
                primaryButton: .default(Text("OK")),
                secondaryButton: .destructive(Text("Don't show this message again")) {
                    hideCheckmarkMessage = true
                }
            )
        }
        .sheet(isPresented: $isEditing) {
            EditTaskView(viewModel: viewModel, item: item)
        }
    }
}


//CURRENT
//struct EditTaskView: View {
//    @Environment(\.presentationMode) var presentationMode
//    @ObservedObject var viewModel: ToDoListItemsVM
//    @State var item: ToDoListitem
//
//    var body: some View {
//        VStack {
//            Text("Edit Task")
//                .font(.title)
//                .fontWeight(.bold)
//                .padding()
//                .foregroundColor(ColorPalette.textPrimary)
//
//            // Title TextField
//            TextField("Task Name", text: $item.title)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//                .background(ColorPalette.secondaryBackground)
//                .cornerRadius(8)
//                .foregroundColor(ColorPalette.textPrimary)
//                .padding([.top, .horizontal])
//
//            // Description TextField
//            TextField("Task Description", text: Binding(
//                get: { item.description ?? "" },
//                set: { item.description = $0 }
//            ))
//            .textFieldStyle(RoundedBorderTextFieldStyle())
//            .padding()
//            .background(ColorPalette.secondaryBackground)
//            .cornerRadius(8)
//            .foregroundColor(ColorPalette.textPrimary)
//            .padding([.top, .horizontal])
//
//            // Color Picker
//            Section(header: Text("Task Color").foregroundColor(ColorPalette.textPrimary)) {
//                Picker("Choose a color", selection: $item.color) {
//                    Text("Red").tag("Red")
//                    Text("Blue").tag("Blue")
//                    Text("Green").tag("Green")
//                    Text("Yellow").tag("Yellow")
//                    Text("Default").tag("Default")
//                }
//                .pickerStyle(MenuPickerStyle())
//                .padding()
//                .background(ColorPalette.secondaryBackground)
//                .cornerRadius(8)
//                .foregroundColor(ColorPalette.textPrimary)
//                .padding([.top, .horizontal])
//            }
//
//            // Due Date and Time Picker
//            Section(header: Text("Due Date & Time").foregroundColor(ColorPalette.textPrimary)) {
//                DatePicker("Select Due Date & Time", selection: Binding(
//                    get: { Date(timeIntervalSince1970: item.dueDate) },
//                    set: { item.dueDate = $0.timeIntervalSince1970 }
//                ), displayedComponents: [.date, .hourAndMinute])
//                .padding()
//                .background(ColorPalette.secondaryBackground)
//                .cornerRadius(8)
//                .foregroundColor(ColorPalette.textPrimary)
//                .padding([.top, .horizontal])
//            }
//
//            // Notification Picker
//            Section(header: Text("Notification Alert").foregroundColor(ColorPalette.textPrimary)) {
//                Picker("Notify me before", selection: $item.notifyBefore) {
//                    Text("None").tag(nil as TimeInterval?)
//                    Text("5 minutes").tag(300 as TimeInterval?)
//                    Text("15 minutes").tag(900 as TimeInterval?)
//                    Text("30 minutes").tag(1800 as TimeInterval?)
//                    Text("1 hour").tag(3600 as TimeInterval?)
//                }
//                .pickerStyle(MenuPickerStyle())
//                .padding()
//                .background(ColorPalette.secondaryBackground)
//                .cornerRadius(8)
//                .foregroundColor(ColorPalette.textPrimary)
//                .padding([.top, .horizontal])
//            }
//
//            Spacer()
//
//            // Save Changes Button
//            Button("Save Changes") {
//                viewModel.updateTask(item: item)
//                presentationMode.wrappedValue.dismiss()
//            }
//            .padding()
//            .frame(maxWidth: .infinity)
//            .background(ColorPalette.buttonBackground)
//            .foregroundColor(.white)
//            .cornerRadius(10)
//            .padding()
//
//            // Cancel Button
//            Button("Cancel") {
//                presentationMode.wrappedValue.dismiss()
//            }
//            .padding()
//            .frame(maxWidth: .infinity)
//            .background(ColorPalette.disabledColor)
//            .foregroundColor(.white)
//            .cornerRadius(10)
//            .padding([.bottom, .horizontal])
//        }
//        .padding()
//        .background(ColorPalette.primaryBackground)
//        .cornerRadius(12)
//        .shadow(color: ColorPalette.shadowColor, radius: 10, x: 0, y: 10)
//        .padding()
//    }
//}


struct EditTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: ToDoListItemsVM
    @State var item: ToDoListitem

    var body: some View {
        NavigationView {
            Form {
                // Title
                Section(header: Text("Title").foregroundColor(ColorPalette.textPrimary)) {
                    TextField("Task Name", text: $item.title)
                        .textFieldStyle(DefaultTextFieldStyle())
//                        .foregroundColor(ColorPalette.textPrimary)
                }

                // Description
                Section(header: Text("Description").foregroundColor(ColorPalette.textPrimary)) {
                    TextField("Task Description", text: Binding(
                        get: { item.description ?? "" },
                        set: { item.description = $0 }
                    ))
                        .textFieldStyle(DefaultTextFieldStyle())
//                        .foregroundColor(ColorPalette.textPrimary)
                }

                // Task Color
                Section(header: Text("Task Color").foregroundColor(ColorPalette.textPrimary)) {
                    Picker("Choose a color", selection: $item.color) {
                        Text("Red").tag("Red")
                        Text("Blue").tag("Blue")
                        Text("Green").tag("Green")
                        Text("Yellow").tag("Yellow")
                        Text("Default").tag("Default")
                    }
                    .pickerStyle(MenuPickerStyle())
//                    .padding()
//                    .background(ColorPalette.secondaryBackground)
                    .cornerRadius(8)
                    .foregroundColor(ColorPalette.textPrimary)
                }

                // Due Date & Time
                Section(header: Text("Due Date & Time").foregroundColor(ColorPalette.textPrimary)) {
                    DatePicker("Select Due Date & Time", selection: Binding(
                        get: { Date(timeIntervalSince1970: item.dueDate) },
                        set: { item.dueDate = $0.timeIntervalSince1970 }
                    ), displayedComponents: [.date, .hourAndMinute])
//                        .padding()
//                        .background(ColorPalette.secondaryBackground)
                        .cornerRadius(8)
                        .foregroundColor(ColorPalette.textPrimary)
                }

                // Notification Picker
                Section(header: Text("Notification Alert").foregroundColor(ColorPalette.textPrimary)) {
                    Picker("Notify me before", selection: $item.notifyBefore) {
                        Text("None").tag(nil as TimeInterval?)
                        Text("5 minutes").tag(300 as TimeInterval?)
                        Text("15 minutes").tag(900 as TimeInterval?)
                        Text("30 minutes").tag(1800 as TimeInterval?)
                        Text("1 hour").tag(3600 as TimeInterval?)
                    }
                    .pickerStyle(MenuPickerStyle())
//                    .padding()
//                    .background(ColorPalette.secondaryBackground)
                    .cornerRadius(8)
                    .foregroundColor(ColorPalette.textPrimary)
                }

                // Save Changes Button
                Section {
                    Button("Save Changes") {
                        viewModel.updateTask(item: item)
                        presentationMode.wrappedValue.dismiss()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(ColorPalette.buttonBackground)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding([.top, .horizontal])

                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(ColorPalette.disabledColor)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding([.bottom, .horizontal])
                }


                // Cancel Button
//                Section {
//                    Button("Cancel") {
//                        presentationMode.wrappedValue.dismiss()
//                    }
//                    .padding()
//                    .frame(maxWidth: .infinity)
//                    .background(ColorPalette.disabledColor)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//                    .padding([.bottom, .horizontal])
//                }
            }
            .background(ColorPalette.primaryBackground.ignoresSafeArea())
            .navigationTitle("Edit Task")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// Preview
//#Preview {
//    EditTaskView(viewModel: ToDoListItemsVM(), item: ToDoListitem(id: UUID(), title: "Sample Task", description: "Task Description", color: "Red", dueDate: Date().timeIntervalSince1970, notifyBefore: 300), presentationMode: .constant(.active))
//}



extension ToDoListItemsVM {
    func getTaskColor(for colorName: String?) -> Color {
        switch colorName {
        case "Red": return .red
        case "Blue": return .blue
        case "Green": return .green
        case "Yellow": return .yellow
        default: return .gray // Default color
        }
    }
}

