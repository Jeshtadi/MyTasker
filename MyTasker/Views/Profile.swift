
//WORKING AND FINAL
import SwiftUI
import PhotosUI
import FirebaseFirestore
import FirebaseAuth


struct Profile: View {
    @StateObject var viewModel = ProfileVM()
    @FirestoreQuery var items: [ToDoListitem]
    @State private var selectedImage: UIImage?
    @State private var showImagePicker = false
    
    var completedTasksCount: Int {
        items.filter { $0.isDone }.count
    }
    var remainingTasksCount: Int {
        items.filter { !$0.isDone }.count
    }
    var body: some View {
        VStack(spacing: 20) {
            if let user = viewModel.user {
                profile(user: user)
            } else {
                ProgressView("Loading Profile...")
                    .progressViewStyle(CircularProgressViewStyle(tint: ColorPalette.accentColor))
            }
        }
        .navigationTitle("")
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Profile")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(ColorPalette.textPrimary) 
            }
        }

    }
    
    @ViewBuilder
    func profile(user: User) -> some View {
        VStack(spacing: 20) {
            // Profile Picture
            ZStack(alignment: .bottomTrailing) {
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 130, height: 130)
                        .shadow(radius: 5)
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 130, height: 130)
                        .foregroundColor(ColorPalette.accentColor)
                        .shadow(radius: 5)
                }
                
                // Edit Button
                Button(action: {
                    showImagePicker = true
                }) {
                    Image(systemName: "pencil.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .background(Color.white)
                        .clipShape(Circle())
                        .offset(x: -5, y: -5)
                }
            }
            .onTapGesture {
                showImagePicker = true
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $selectedImage)
            }

            // User Info
            VStack(alignment: .center, spacing: 15) {
                infoRow(title: "Name", value: user.name)
                infoRow(title: "Email", value: user.email)
                infoRow(title: "Member Since", value: Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated, time: .omitted))
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(ColorPalette.secondaryBackground)
            .cornerRadius(15)
            .shadow(radius: 5)

            // Task Summary
//            HStack(spacing: 20) {
//                
//                taskSummary(title: "Completed", count: completedTasksCount, color: .green)
//                    .frame(maxWidth: .infinity, minHeight: 90)
//                    
//                taskSummary(title: "Pending", count: remainingTasksCount, color: .red)
//                    .frame(maxWidth: .infinity, minHeight: 90)
//            }
//
//            .padding(.horizontal)
//            .frame(maxWidth: .infinity)
            
            VStack(alignment: .center, spacing: 10) {
                // Title for the task summary section
                Text("Task Summary")
                    .font(.headline) // Adjust font size as needed
//                    .foregroundColor(ColorPalette.textPrimary)
                
                // Task summary HStack
                HStack {
                    taskSummary(title: "Completed", count: completedTasksCount, color: .green)
                        .frame(maxWidth: .infinity)
                        .padding(.trailing, 10)
                    
                    taskSummary(title: "Pending", count: remainingTasksCount, color: .red)
                        .frame(maxWidth: .infinity)
                        .padding(.leading, 10)
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity, maxHeight: 150)
                .cornerRadius(15)
                .shadow(radius: 5)
            }
            .padding()


            // Settings & Logout
//            VStack {
//                NavigationLink(destination: SettingsView()) {
//                    HStack {
//                       
//                        Image(systemName: "gear")
//                            .font(.title2)
//                            .foregroundColor(ColorPalette.textPrimary)
//                        Text("Settings")
//                            .font(.title2)
//                            .foregroundColor(ColorPalette.textPrimary)
//                    }
//                    .padding()
//                    .frame(maxWidth: .infinity)
//                    .background(ColorPalette.secondaryBackground)
//                    .cornerRadius(10)
//                    .shadow(radius: 3)
//                }
//
////                Button(action: {
////                    viewModel.logOut()
////                }) {
////                    Text("Log Out")
////                        .frame(maxWidth: .infinity)
////                        .padding()
////                        .foregroundColor(.white)
////                        .background(ColorPalette.buttonBackground)
////                        .cornerRadius(10)
////                        .shadow(radius: 3)
////                }
//            }
        }
        .padding()
    }
    
    func infoRow(title: String, value: String) -> some View {
        HStack {
            Text("\(title):")
                .font(.headline)
                .foregroundColor(ColorPalette.textPrimary)
            
            Spacer()
            
            Text(value)
                .foregroundColor(ColorPalette.textPrimary)
        }
    }
    
    func taskSummary(title: String, count: Int, color: Color) -> some View {
        VStack {
            Text("\(count)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(color)
            Text(title)
                .foregroundColor(ColorPalette.textPrimary)
        }
        .frame(width: 130, height: 130)
        .background(ColorPalette.secondaryBackground)
        .cornerRadius(10)
//        .shadow(radius: 3)
    }
}

//#Preview {
//    Profile()
//}

// Image Picker Component
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            picker.dismiss(animated: true)
        }
    }
}
