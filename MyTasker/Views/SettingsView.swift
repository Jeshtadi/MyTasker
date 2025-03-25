//
//  SettingsView.swift
//  MyTasker
//
//  Created by Anushya Jeshtadi on 26/01/2025.
//


import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = ProfileVM()
    
    @State private var currentPassword = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    var body: some View {
        List {
            Section {
                NavigationLink("Account", destination: AccountView())
                NavigationLink("Notifications", destination: NotificationsView())
                NavigationLink("Display", destination: DisplayView())
            }
            
            Section {
                SecureField("Enter Current Password", text: $currentPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                    viewModel.deleteAccount(currentPassword: currentPassword){ error in
                        if let error = error {
                            alertMessage = "Error: \(error.localizedDescription)"
                        } else {
                            alertMessage = "Account deleted successfully."
                        }
                        showAlert = true
                    }
                }) {
                    Text("Delete Account")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(10)
                        .shadow(radius: 3)
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Account Deletion"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
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
//                Button("Log Out", role: .destructive) {
//                    // Log out action
//                }
            }
        }
        .navigationTitle("Settings")
    }
}

// Account Page - Edit username and password
//import SwiftUI

struct AccountView: View {
    @StateObject private var viewModel = ProfileVM()

    @State private var firstName: String = ""
    @State private var lastName: String = ""
//    @State private var email: String = ""
    @State private var currentPassword = ""
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    if let user = viewModel.user {
                        accountDetails(user: user)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(ColorPalette.primaryBackground.ignoresSafeArea())
                .navigationTitle("Account")
            }
            .onAppear {
                viewModel.fetchUser() // Fetch the current user's data
            }
        }
    }
    
    @ViewBuilder
    func accountDetails(user: User) -> some View {
        // Populate text fields with current user details
        Group {
            Text("First Name:")
            TextField("First Name", text: $firstName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .onAppear {
                    firstName = user.name // Set initial value to current user's name
                }
            
            Text("Last Name:")
            TextField("Last Name", text: $lastName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .onAppear {
                    lastName = user.lastName // Set initial value to current user's last name
                }
            
//            Text("Email:")
//            TextField("Email", text: $email)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding(.horizontal)
//                .onAppear {
//                    email = user.email // Set initial value to current user's email
//                }
            
            Divider()
            
            Text("New Password:")
            SecureField("New Password", text: $newPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            Text("Confirm Password:")
            SecureField("Confirm Password", text: $confirmPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
        }
        
        // Save Changes Button
        Button(action: {
            saveChanges(user: user)
        }) {
            Text("Save Changes")
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(ColorPalette.buttonBackground)
                .cornerRadius(10)
                .shadow(radius: 3)
        }
        .padding(.top)
    }
    
    func saveChanges(user: User) {
        // Check if passwords match
        guard newPassword == confirmPassword else {
            print("Passwords do not match!")
            return
        }

        // Save the updated user details
        viewModel.updateUserInfo(firstName: firstName, lastName: lastName)

        // Only update email if it was changed
//        if email != user.email {
//            viewModel.updateEmail(newEmail: email)
//        }

        // Only update password if a new password is entered
        if !newPassword.isEmpty {
            viewModel.updatePassword(newPassword: newPassword, currentPassword: currentPassword) { error in
                if let error = error {
                    print("Error updating password: \(error)")
                } else {
                    print("Password updated successfully!")
                }
            }
        }
    }
}



// Notifications Page - Toggle notifications on/off
struct NotificationsView: View {
    @State private var notificationsEnabled = true

    var body: some View {
        NavigationStack {
            Form {
                Toggle("Enable Notifications", isOn: $notificationsEnabled)
            }
            .navigationTitle("Notifications")
        }
    }
}

// Display Page - Choose dark, light, or system default mode
import SwiftUI

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
    
    /// Updates the UI appearance based on the selected color scheme.
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



#Preview {
    NavigationStack { // Wrap SettingsView in NavigationStack only in preview
        AccountView()
    }
}


