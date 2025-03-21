


//import SwiftUI
//import FirebaseFirestore



// like this code working
//import SwiftUI
//import FirebaseFirestore
//
//struct AfterLoginView: View {
//    @StateObject private var profileVM = ProfileVM()
//    @FirestoreQuery var items: [ToDoListitem]
//    
//    @State private var selectedCategory: String = "todos" // Default to Todos
//    
//    init(userId: String) {
//        self._items = FirestoreQuery(collectionPath: "users/\(userId)/todos")
//    }
//    
//    // Filtered task categories
//    var todos: [ToDoListitem] {
//        items.filter { !$0.isDone && Date(timeIntervalSince1970: $0.dueDate) <= Date() }
//    }
//    
//    var inProgress: [ToDoListitem] {
//        items.filter { !$0.isDone && Date(timeIntervalSince1970: $0.dueDate) > Date() }
//    }
//    
//    var done: [ToDoListitem] {
//        items.filter { $0.isDone }
//    }
//    
//    // Delete task from Firestore
//    func deleteTask(taskId: String) {
//        let db = Firestore.firestore()
//        db.collection("users/\(profileVM.user?.id ?? "")/todos").document(taskId).delete { error in
//            if let error = error {
//                print("Error deleting document: \(error.localizedDescription)")
//            } else {
//                print("Document successfully deleted!")
//            }
//        }
//    }
//    
//    // Mark task as done
//    func markTaskAsDone(taskId: String) {
//        let db = Firestore.firestore()
//        db.collection("users/\(profileVM.user?.id ?? "")/todos").document(taskId).updateData([
//            "isDone": true
//        ]) { error in
//            if let error = error {
//                print("Error marking task as done: \(error.localizedDescription)")
//            } else {
//                print("Task marked as done!")
//            }
//        }
//    }
//
//    // Calculate remaining tasks
//    var remainingTasksCount: Int {
//        items.filter { !$0.isDone }.count
//    }
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                Text("You have \(remainingTasksCount) task\(remainingTasksCount == 1 ? "" : "s") to finish")
//                    .font(.headline)
//                    .padding(.top, 10)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding(.horizontal)
//                    .foregroundColor(ColorPalette.textPrimary)
//
//                // Category selection buttons
//                HStack {
//                    CategoryButton(title: "Todos", icon: "list.dash", isSelected: selectedCategory == "todo") {
//                        selectedCategory = "todo"
//                    }
//                    CategoryButton(title: "In Progress", icon: "arrow.right.circle.fill", isSelected: selectedCategory == "inProgress") {
//                        selectedCategory = "inProgress"
//                    }
//                    CategoryButton(title: "Done", icon: "checkmark.circle.fill", isSelected: selectedCategory == "done") {
//                        selectedCategory = "done"
//                    }
//                }
//                .padding(.top, 40)
//                
//                Text("Your Tasks")
//                    .font(.title2)
//                    .fontWeight(.bold)
//                    .padding(.top, 20)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding(.horizontal)
//                    .foregroundColor(ColorPalette.textPrimary)
//
//                List {
//                    ForEach(selectedCategory == "todo" ? todos :
//                            selectedCategory == "inProgress" ? inProgress : done) { item in
//                        ToDoListitems(item: item)
//                            .swipeActions {
//                                if selectedCategory != "done" {
//                                    Button("Mark Done") {
//                                        markTaskAsDone(taskId: item.id)
//                                    }
//                                    .tint(Color.green)
//                                }
//                                Button("Delete") {
//                                    deleteTask(taskId: item.id)
//                                }
//                                .tint(Color.red)
//                            }
//                    }
//                }
//                .listStyle(PlainListStyle())
//            }
//            .navigationTitle("Good Morning, \(profileVM.user?.name ?? "User")")
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    NavigationLink(destination: Profile()) {
//                        Image(systemName: "person.circle")
//                            .font(.title2)
//                            .foregroundColor(ColorPalette.textPrimary)
//                    }
//                }
//            }
//            .onAppear {
//                profileVM.fetchUser()
//            }
//        }
//    }
//}
//
//// Custom Button View for Categories
//struct CategoryButton: View {
//    var title: String
//    var icon: String
//    var isSelected: Bool
//    var action: () -> Void
//
//    var body: some View {
//        Button(action: action) {
//            VStack {
//                Image(systemName: icon)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 40, height: 40)
//                    .foregroundColor(isSelected ? Color.white : ColorPalette.textPrimary)
//                Text(title)
//                    .font(.headline)
//                    .foregroundColor(isSelected ? Color.white : ColorPalette.textPrimary)
//            }
//            .frame(maxWidth: 100, maxHeight: 100)
//            .padding()
//            .background(isSelected ? ColorPalette.accentColor : ColorPalette.secondaryBackground)
//            .cornerRadius(10)
//        }
//    }
//}
//
//// Preview
//struct AfterLoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        AfterLoginView(userId: "sampleUserId")
//            .environmentObject(ProfileVM())
//            .preferredColorScheme(.light)
//    }
//}



import SwiftUI
import FirebaseFirestore

struct AfterLoginView: View {
    @StateObject private var profileVM = ProfileVM()
    @FirestoreQuery var items: [ToDoListitem]
    
    @State private var selectedCategory: String = "todo" // Ensuring "Todos" is the default view

    init(userId: String) {
        self._items = FirestoreQuery(collectionPath: "users/\(userId)/todos")
    }
    
    // Filtered task categories
    var todos: [ToDoListitem] {
        items.filter { !$0.isDone && Date(timeIntervalSince1970: $0.dueDate) <= Date() }
    }
    
    var inProgress: [ToDoListitem] {
        items.filter { !$0.isDone && Date(timeIntervalSince1970: $0.dueDate) > Date() }
    }
    
    var done: [ToDoListitem] {
        items.filter { $0.isDone }
    }
    
    // Delete task from Firestore
    func deleteTask(taskId: String) {
        let db = Firestore.firestore()
        db.collection("users/\(profileVM.user?.id ?? "")/todos").document(taskId).delete { error in
            if let error = error {
                print("Error deleting document: \(error.localizedDescription)")
            } else {
                print("Document successfully deleted!")
            }
        }
    }
    
    // Mark task as done
    func markTaskAsDone(taskId: String) {
        let db = Firestore.firestore()
        db.collection("users/\(profileVM.user?.id ?? "")/todos").document(taskId).updateData([
            "isDone": true
        ]) { error in
            if let error = error {
                print("Error marking task as done: \(error.localizedDescription)")
            } else {
                print("Task marked as done!")
            }
        }
    }

    // Calculate remaining tasks
    var remainingTasksCount: Int {
        items.filter { !$0.isDone }.count
    }

    var body: some View {
        NavigationView {
            VStack {
                Text("You have \(remainingTasksCount) task\(remainingTasksCount == 1 ? "" : "s") to finish")
                    .font(.headline)
                    .padding(.top, 10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .foregroundColor(ColorPalette.textPrimary)

                // Category selection buttons
//                HStack {
//                    CategoryButton(title: "Todos", icon: "list.dash", isSelected: selectedCategory == "todo") {
//                        selectedCategory = "todo"
//                    }
//                    CategoryButton(title: "In Progress", icon: "arrow.right.circle.fill", isSelected: selectedCategory == "inProgress") {
//                        selectedCategory = "inProgress"
//                    }
//                    CategoryButton(title: "Done", icon: "checkmark.circle.fill", isSelected: selectedCategory == "done") {
//                        selectedCategory = "done"
//                    }
//                }
//                .padding(.top, 40)
                HStack {
                    CategoryButton(title: "Todos", icon: "list.dash", isSelected: selectedCategory == "todo") {
                        selectedCategory = "todo"
                    }
                    .frame(width: 100, height: 50) // Set width and height for the button
                    .padding(.horizontal, 10) // Add horizontal padding for spacing between buttons

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
                .padding(.top, 40) // Adjust the top padding for the entire HStack
                .frame(maxWidth: .infinity, alignment: .center) // Make the HStack stretch across the screen, centered

                
                Text("Your Tasks")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .foregroundColor(ColorPalette.textPrimary)

                List {
                    ForEach(selectedCategory == "todo" ? todos :
                            selectedCategory == "inProgress" ? inProgress : done) { item in
                        ToDoListitems(item: item)
                            .foregroundColor(Color.black)
                            .swipeActions {
                                if selectedCategory != "done" {
                                    Button("Mark Done") {
                                        markTaskAsDone(taskId: item.id)
                                    }
                                    .tint(Color.green)
                                }
                                Button("Delete") {
                                    deleteTask(taskId: item.id)
                                }
                                .tint(Color.red)
                            }
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Good Morning, \(profileVM.user?.name ?? "User")")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: Profile()) {
                        Image(systemName: "person.circle")
                            .font(.title2)
                            .foregroundColor(ColorPalette.textPrimary)
                    }
                }
            }
            .onAppear {
                profileVM.fetchUser()
                selectedCategory = "todo" // Ensures "Todos" is always selected when the view appears
            }
        }
    }
}

// Custom Button View for Categories
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
                    .frame(width: 40, height: 40)
                    .foregroundColor(isSelected ? Color.black : ColorPalette.textPrimary)
                Text(title)
                    .font(.headline)
                    .foregroundColor(isSelected ? Color.black : ColorPalette.textPrimary)
            }
            .frame(maxWidth: 100, maxHeight: 100)
            .padding()
            .background(isSelected ? ColorPalette.accentColor : ColorPalette.secondaryBackground)
            .cornerRadius(10)
        }
    }
}

// Preview
struct AfterLoginView_Previews: PreviewProvider {
    static var previews: some View {
        AfterLoginView(userId: "sampleUserId")
            .environmentObject(ProfileVM())
            .preferredColorScheme(.light)
    }
}
