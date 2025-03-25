//
//  Profile.swift
//  MyTasker
//
//  Created by Anushya Jeshtadi on 22/01/2025.
//
//working profile
//import SwiftUI
//
//struct Profile: View {
//    @StateObject var viewModel = ProfileVM()
//    
//    var body: some View {
//        NavigationView {
//            VStack(spacing: 20) {
//                if let user = viewModel.user {
//                    profile(user: user)
//                } else {
//                    ProgressView("Loading Profile...")
//                        .progressViewStyle(CircularProgressViewStyle(tint: ColorPalette.accentColor))
//                }
//            }
//            .padding()
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .background(ColorPalette.primaryBackground.ignoresSafeArea())
//            .navigationTitle("Profile")
//        }
//        .onAppear {
//            viewModel.fetchUser()
//        }
//    }
//    
//    @ViewBuilder
//    func profile(user: User) -> some View {
//        VStack(spacing: 20) {
//            Image(systemName: "person.circle.fill")
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(width: 130, height: 130)
//                .foregroundColor(ColorPalette.accentColor)
//                .shadow(radius: 5)
//                
//            VStack(alignment: .leading, spacing: 15) {
//                infoRow(title: "Name", value: user.name)
//                infoRow(title: "Email", value: user.email)
//                infoRow(title: "Member Since", value: Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated, time: .omitted))
//            }
//            .padding()
//            .frame(maxWidth: .infinity)
//            .background(ColorPalette.secondaryBackground)
//            .cornerRadius(15)
//            .shadow(radius: 5)
//            
//            Button(action: {
//                viewModel.logOut()
//            }) {
//                Text("Log Out")
//                    .frame(maxWidth: .infinity)
//                    .padding()
//                    .foregroundColor(.white)
//                    .background(ColorPalette.buttonBackground)
//                    .cornerRadius(10)
//                    .shadow(radius: 3)
//            }
//        }
//        .padding()
//    }
//    
//    func infoRow(title: String, value: String) -> some View {
//        HStack {
//            Text("\(title):")
//                .font(.headline)
//                .foregroundColor(ColorPalette.textPrimary)
//            
//            Spacer()
//            
//            Text(value)
//                .foregroundColor(ColorPalette.textPrimary)
//        }
//    }
//}
//
//#Preview {
//    Profile()
//}





import SwiftUI
import PhotosUI
import FirebaseFirestore
import FirebaseAuth


struct Profile: View {
    @StateObject var viewModel = ProfileVM()
    @FirestoreQuery var items: [ToDoListitem]
    @State private var selectedImage: UIImage? // Store user-selected image
    @State private var showImagePicker = false
    
    
    
    var completedTasksCount: Int {
        items.filter { $0.isDone }.count
    }
    var remainingTasksCount: Int {
        items.filter { !$0.isDone }.count
    }
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                if let user = viewModel.user {
                    profile(user: user)
                } else {
                    ProgressView("Loading Profile...")
                        .progressViewStyle(CircularProgressViewStyle(tint: ColorPalette.accentColor))
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(ColorPalette.primaryBackground.ignoresSafeArea())
            .navigationTitle("Profile")
        }
        .onAppear {
            viewModel.fetchUser()
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
            HStack {
                taskSummary(title: "Completed Tasks", count:
                                completedTasksCount, color: .green)
                Spacer()
                taskSummary(title: "Pending Tasks", count:
                                remainingTasksCount, color: .red)
            }
            .padding(.horizontal)

            // Settings & Logout
            VStack {
                NavigationLink(destination: SettingsView()){
                    
                    HStack {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .shadow(radius: 3)
                }

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
        .frame(width: 120, height: 80)
        .background(ColorPalette.secondaryBackground)
        .cornerRadius(10)
        .shadow(radius: 3)
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
