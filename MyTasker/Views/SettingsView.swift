//
//  SettingsView.swift
//  MyTasker
//
//  Created by Anushya Jeshtadi on 26/01/2025.



import SwiftUI
import UserNotifications
import FirebaseFirestore
import FirebaseAuth



struct SettingsView: View {
    @StateObject private var viewModel = ProfileVM()
    
    @State private var currentPassword = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var showDeleteConfirmation = false
    @State private var showPasswordEntry = false
    @State private var showDeletionWarning = false

    var body: some View {
        VStack(alignment: .leading) {
            Text("Settings")
                .font(.largeTitle)
                .textCase(nil)
                .bold()
                .padding(.horizontal)
                .padding(.top, 20)
            List {
                
                Section {
                    NavigationLink("Account", destination: AccountView())
                    NavigationLink("Notifications", destination: NotificationsView())
                    NavigationLink("Display", destination: DisplayView())
                    //                NavigationLink("Recently Deleted", destination: RecentlyDeletedView())
                    
                }
                
                Section {
                    Button(action: {
                        showDeleteConfirmation.toggle()
                        showDeletionWarning = true
                    }) {
                        Text("Delete Account")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.red)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                    }
                    .padding(.top, 10)
                    
                    Button(action: {
                        viewModel.logOut()
                    }) {
                        Text("Log Out")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(ColorPalette.buttonBackground)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                    }
                }
            }
            .navigationTitle("Settings")
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Account Deletion"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            .sheet(isPresented: $showDeleteConfirmation) {
                VStack {
                    Text("Warning: All your data will be deleted. Are you sure you want to delete your account?")
                        .padding()
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                    
                    HStack {
                        Button("Yes") {
                            showDeleteConfirmation = false
                            showPasswordEntry = true
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        
                        Button("Cancel") {
                            
                            showDeleteConfirmation = false
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                    }
                    .padding(.top, 10)
                }
                .padding()
            }
            .sheet(isPresented: $showPasswordEntry) {
                VStack {
                    Text("Please enter your current password to confirm account deletion:")
                        .padding()
                    
                    SecureField("Enter Current Password", text: $currentPassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Button(action: {
                        viewModel.deleteAccount(currentPassword: currentPassword) { error in
                            if let _ = error {  // Directly check for error
                                alertMessage = "Invalid credentials. Please try again."
                            } else {
                                alertMessage = "Account deleted successfully."
                            }
                            showAlert = true
                        }
                        showPasswordEntry = false
                    }) {
                        Text("Confirm Deletion")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.red)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                    }
                    .padding(.top, 10)
                    
                    Button("Cancel") {
                        showPasswordEntry = false
                    }
                    .padding()
                    .foregroundColor(.blue)
                }
                .padding()
            }
        }
    }
}

struct AccountView: View {
    @StateObject private var viewModel = ProfileVM()

    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var currentPassword: String = ""
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""
    @State private var errorMessage: String = ""
    @State private var successMessage: String = ""

    var body: some View {
        NavigationView {
            Form {
                // User Information Section
                Section(header: Text("User Information").font(.headline)) {
                    if let user = viewModel.user {
                        TextField("First Name", text: $firstName)
                            .onAppear {
                                firstName = user.name
                            }
                        TextField("Last Name", text: $lastName)
                            .onAppear {
                                lastName = user.lastName
                            }
                    }
                }
                
               
                Section(header: Text("Change Password").font(.headline)) {
                    SecureField("Current Password", text: $currentPassword)
                    SecureField("New Password", text: $newPassword)
                    SecureField("Confirm Password", text: $confirmPassword)
                }

             
                Section {
                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    }
                    
                    if !successMessage.isEmpty {
                        Text(successMessage)
                            .foregroundColor(.green)
                            .padding()
                    }
                }

                
                Section {
                    Button(action: {
                        saveChanges()
                    }) {
                        Text("Save Changes")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                    }
                }
            }
            .navigationTitle("Account")
            .onAppear {
                viewModel.fetchUser()
            }
        }
    }

    func saveChanges() {
        
        guard newPassword == confirmPassword else {
            errorMessage = "Passwords do not match!"
            successMessage = ""
            return
        }

        // Update user info
        viewModel.updateUserInfo(firstName: firstName, lastName: lastName)

        // Update password if entered
        if !newPassword.isEmpty {
            viewModel.updatePassword(newPassword: newPassword, currentPassword: currentPassword) { error in
                if let error = error {
                    errorMessage = error
                    successMessage = ""
                } else {
                    successMessage = "Password updated successfully!"
                    errorMessage = ""
                }
            }
        }
    }
}


//struct NotificationsView: View {
//    @AppStorage("notificationsEnabled") private var notificationsEnabled: Bool = false
//
//    var body: some View {
//        NavigationStack {
//            Form {
//                Toggle("Enable Notifications", isOn: $notificationsEnabled)
//                    .onChange(of: notificationsEnabled) { newValue in
//                        if newValue {
//                            requestNotificationPermission()
//                        } else {
//                            removeScheduledNotifications()
//                        }
//                    }
//            }
//            .navigationTitle("Notifications")
//        }
//    }
//
//    func requestNotificationPermission() {
//        let center = UNUserNotificationCenter.current()
//        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
//            DispatchQueue.main.async {
//                notificationsEnabled = granted
//            }
//        }
//    }
//
//    func removeScheduledNotifications() {
//        let center = UNUserNotificationCenter.current()
//        center.removeAllPendingNotificationRequests()
//        print("All scheduled notifications have been removed.")
//    }
//}


// diabled workes
//struct NotificationsView: View {
//    @AppStorage("notificationsEnabled") private var notificationsEnabled: Bool = false
//
//    var body: some View {
//        NavigationStack {
//            Form {
//                Toggle("Enable Notifications", isOn: $notificationsEnabled)
//                    .onChange(of: notificationsEnabled) { newValue in
//                        if newValue {
//                            NotificationManager.shared.requestPermission { granted in
//                                if granted {
//                                    UserDefaults.standard.set(true, forKey: "notificationsEnabled")
//                                    print("Notifications enabled")
//                                } else {
//                                    UserDefaults.standard.set(false, forKey: "notificationsEnabled")
//                                    print("Permission denied")
//                                    notificationsEnabled = false
//                                }
//                            }
//                        } else {
//                            NotificationManager.shared.removeAllNotifications()
//                            UserDefaults.standard.set(false, forKey: "notificationsEnabled")
//                            print("Notifications disabled")
//                        }
//                    }
//            }
//            .navigationTitle("Notifications")
//        }
//    }
//}


struct NotificationsView: View {
    @AppStorage("notificationsEnabled") private var notificationsEnabled: Bool = false

    var body: some View {
        NavigationStack {
            Form {
                Toggle("Enable Notifications", isOn: $notificationsEnabled)
                    .onChange(of: notificationsEnabled) { newValue in
                        if newValue {
                            NotificationManager.shared.requestPermission { granted in
                                if granted {
                                    UserDefaults.standard.set(true, forKey: "notificationsEnabled")
                                    print("Notifications enabled")
                                } else {
                                    // If permission is not granted, revert toggle and notify user
                                    UserDefaults.standard.set(false, forKey: "notificationsEnabled")
                                    notificationsEnabled = false
                                    print("Permission denied")
                                }
                            }
                        } else {
                            NotificationManager.shared.removeAllNotifications()
                            UserDefaults.standard.set(false, forKey: "notificationsEnabled")
                            print("Notifications disabled")
                        }
                    }
            }
            .navigationTitle("Notifications")
            .onAppear {
                // Ensure the toggle reflects the stored value in UserDefaults
                notificationsEnabled = UserDefaults.standard.bool(forKey: "notificationsEnabled")
            }
        }
    }
}




struct DisplayView: View {
    @AppStorage("colorScheme") private var colorScheme: String = "System"
    
    var body: some View {
        NavigationStack {
            Form {
                Picker("Appearance", selection: $colorScheme) {
                    Text("Light").tag("Light")
                    Text("Dark").tag("Dark")
                    Text("System Default").tag("System")
                }
                .pickerStyle(SegmentedPickerStyle())
                .onChange(of: colorScheme) { oldValue, newValue in
                    updateAppearance(to: newValue)
                }
            }
            .navigationTitle("Display")
        }
        .onAppear {
            updateAppearance(to: colorScheme)
        }
    }
    
    private func updateAppearance(to scheme: String) {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = scene.windows.first {
            switch scheme {
            case "Light":
                window.overrideUserInterfaceStyle = .light
            case "Dark":
                window.overrideUserInterfaceStyle = .dark
            default:
                window.overrideUserInterfaceStyle = .unspecified
            }
        }
    }
}

//struct RecentlyDeletedView: View {
//    @State private var deletedTasks: [ToDoListitem] = []
//    @State private var isLoading = true
//    @StateObject private var viewModel = ToDoListItemsVM()

//    
//    private let db = Firestore.firestore()
//
//    var body: some View {
//        VStack {
//            if isLoading {
//                ProgressView("Loading...")
//                    .padding()
//            } else {
//                Text("Recently Deleted")
//                    .font(.title)
//                    .fontWeight(.bold)
//                    .padding()
//
//                List {
//                    ForEach(deletedTasks) { task in
//                        HStack {
//                            Text(task.title)
//                            Spacer()
//                            Button(action: {
//                                restoreTask(task)
//                            }) {
//                                Text("Restore")
//                                    .foregroundColor(.blue)
//                            }
//                        }
//                    }
//                }
//            }
//        }
//        .onAppear {
//            fetchDeletedTasks() // Fetch deleted tasks when the view appears
//        }
//    }
//
//    func fetchDeletedTasks() {
//        guard let uId = Auth.auth().currentUser?.uid else { return }
//
//        db.collection("users")
//            .document(uId)
//            .collection("todos")
//            .getDocuments { snapshot, error in
//                guard let documents = snapshot?.documents, error == nil else {
//                    print("Failed to fetch tasks: \(error?.localizedDescription ?? "Unknown error")")
//                    return
//                }
//
//                DispatchQueue.main.async {
//                    deletedTasks = documents.compactMap { doc in
//                        let data = doc.data()
//
//                        guard let isDeleted = data["isDeleted"] as? Bool, isDeleted else {
//                            return nil // Ignore non-deleted tasks
//                        }
//
//                        return ToDoListitem(
//                            id: data["id"] as? String ?? UUID().uuidString,
//                            title: data["title"] as? String ?? "",
//                            description: data["description"] as? String ?? "",
//                            dueDate: data["dueDate"] as? TimeInterval ?? 0,
//                            createDate: data["createDate"] as? TimeInterval ?? 0,
//                            duration: data["duration"] as? TimeInterval,
//                            isDone: data["isDone"] as? Bool ?? false,
//                            color: data["color"] as? String ?? "Default",
//                            repeatInterval: data["repeatInterval"] as? TimeInterval,
//                            notifyBefore: data["notifyBefore"] as? TimeInterval
//                        )
//                    }
//                    isLoading = false
//                }
//            }
//    }
//
//
//
//    func restoreTask(_ task: ToDoListitem) {
//        var updatedTask = task
//        updatedTask.isDeleted = false // Set isDeleted to false to restore the task
//        
//        viewModel.updateTask(item: updatedTask) // Update the task in Firestore
//        deletedTasks.removeAll { $0.id == task.id } // Remove from the list of deleted tasks
//    }
//}
//





#Preview {
    NavigationStack {
        AccountView()
    }
}
