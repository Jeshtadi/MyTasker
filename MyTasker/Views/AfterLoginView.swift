
///TESTING NOTIFICATION working now
import SwiftUI
import FirebaseFirestore
import FirebaseAuth
import UserNotifications

struct AfterLoginView: View {
    @StateObject private var profileVM = ProfileVM()
    @FirestoreQuery var items: [ToDoListitem]
    @State private var selectedCategory: String = "todo"
    
    @StateObject var viewModel = ToDoListItemsVM()
    @ObservedObject var toDoListItemsVM = ToDoListItemsVM()
    @State private var showNotificationAlert = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var recentlyDeletedTasks: [ToDoListitem] = []

    
    init(userId: String) {
        self._items = FirestoreQuery(collectionPath: "users/\(userId)/todos")
    }
    
    // Your task categories
    var todos: [ToDoListitem] {
        let todayStart = Calendar.current.startOfDay(for: Date())
        let todayEnd = Calendar.current.date(byAdding: .day, value: 1, to: todayStart)!
        return items.filter { !$0.isDone && Date(timeIntervalSince1970: $0.dueDate) >= todayStart && Date(timeIntervalSince1970: $0.dueDate) < todayEnd }
    }
    
    var inProgress: [ToDoListitem] {
        let todayEnd = Calendar.current.date(byAdding: .day, value: 1, to: Calendar.current.startOfDay(for: Date()))!
        return items.filter { !$0.isDone && Date(timeIntervalSince1970: $0.dueDate) >= todayEnd }
    }
    
    var done: [ToDoListitem] {
        items.filter { $0.isDone }
    }
    


    func deleteTask(taskId: String) {
        let db = Firestore.firestore()
        let taskRef = db.collection("users/\(profileVM.user?.id ?? "")/todos").document(taskId)
         
        taskRef.updateData(["isDeleted": true]) { error in
            if let error = error {
                print("Error updating document: \(error.localizedDescription)")
            } else {
                print("Task marked as deleted successfully.")
                 
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [taskId])
                print("Notification canceled for the task.")
                 
                taskRef.delete { error in
                    if let error = error {
                        print("Error deleting document from todos: \(error.localizedDescription)")
                    } else {
                        print("Task successfully deleted from todos collection!")
                    }
                }
            }
        }
    }

  
    
    // Calculate remaining tasks count
    var remainingTasksCount: Int {
        items.filter { !$0.isDone }.count
    }
    
    // Request notification permission using NotificationManager
    func requestNotificationPermission() {
        NotificationManager.shared.requestPermission { granted in
            if granted {
                UserDefaults.standard.set(true, forKey: "notificationsGranted")
            } else {
                self.showNotificationAlert = true
            }
        }
    }
    
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Good Morning, \(profileVM.user?.name ?? "User")")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .foregroundColor(ColorPalette.textPrimary)
                
                Text("You have \(remainingTasksCount) task\(remainingTasksCount == 1 ? "" : "s") to finish")
                    .font(.headline)
                    .padding(.top, 10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .foregroundColor(ColorPalette.textPrimary)
                
                HStack {
                    CategoryButton(title: "Todos", icon: "list.dash", isSelected: selectedCategory == "todo") {
                        selectedCategory = "todo"
                    }
                    .frame(width: 100, height: 50)
                    .padding(.horizontal, 10)
                    
                    CategoryButton(title: "In Progress", icon: "arrow.right.circle.fill", isSelected: selectedCategory == "inProgress") {
                        selectedCategory = "inProgress"
                    }
                    .frame(width: 100, height: 50)
                    .padding(.horizontal, 10)
                    
                    CategoryButton(title: "Done", icon: "checkmark.circle.fill", isSelected: selectedCategory == "done") {
                        selectedCategory = "done"
                    }
                    .frame(width: 100, height: 50)
                    .padding(.horizontal, 10)
                }
                .padding(.top, 40)
                .frame(maxWidth: .infinity, alignment: .center)
                
                Text("Your Tasks")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top, 50)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .foregroundColor(ColorPalette.textPrimary)
                
                List {
                    ForEach(selectedCategory == "todo" ? todos :
                                selectedCategory == "inProgress" ? inProgress : done) { item in
                        VStack(alignment: .leading) {
                            ToDoListitems(viewModel: viewModel, item: item)
                            
                                .swipeActions {
                                    Button("Delete") {
                                        deleteTask(taskId: item.id)
                                            self.alertMessage = "Your task has been moved to Recently Deleted"
                                            self.showAlert = true
                                        }
                            
                                    }
                                    .tint(Color.red)
                                }
                        }
                        .alert(isPresented: $showAlert) {
                            Alert(title: Text("Task Deleted"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                        }
                    }
                                .listStyle(PlainListStyle())
                }
                
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: Profile(items: _items)) {
                            Image(systemName: "person.circle")
                                .font(.title2)
                                .foregroundColor(ColorPalette.textPrimary)
                        }
                    }
                }
                .onAppear {
                    profileVM.fetchUser()
                    selectedCategory = "todo"
                    requestNotificationPermission() // Now using NotificationManager
                    
                }
                .alert(isPresented: $showNotificationAlert) {
                    Alert(
                        title: Text("Enable Notifications"),
                        message: Text("Notifications are disabled. Please enable them in Settings."),
                        primaryButton: .default(Text("Open Settings"), action: {
                            if let url = URL(string: UIApplication.openSettingsURLString) {
                                UIApplication.shared.open(url)
                            }
                        }),
                        secondaryButton: .cancel()
                    )
                }
                
                
            }
        }
    }


struct CategoryButton: View {
    var title: String
    var icon: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundColor(isSelected ? Color.white : ColorPalette.textPrimary)
                Text(title)
                    .font(.system(size: 14))
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                    .foregroundColor(isSelected ? Color.white : ColorPalette.textPrimary)
                    .padding(.horizontal, 4)
            }
            .frame(width: 110, height: 70)
            .padding(6)
            .background(isSelected ? ColorPalette.accentColor : ColorPalette.secondaryBackground)
            .cornerRadius(10)
        }
    }
}
