//
//  LoginV.swift
//  MyTasker
//
//  Created by Anushya Jeshtadi on 22/01/2025.

import SwiftUI
import FirebaseAuth

struct LoginV: View {
    @StateObject var viewModel = LoginVVm()
    @State private var isPasswordVisible: Bool = false
    @State private var isForgotPasswordAlertPresented: Bool = false
    @State private var resetEmail: String = ""
    @State private var alertMessage: String = ""
    @State private var showAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background Color
                ColorPalette.primaryBackground
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    // Title
                    Text("Welcome Back")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(ColorPalette.textPrimary)
                        .padding(.top, 60)
                    
                    // Email Field
                    VStack(alignment: .leading, spacing: 5) {
                        
                        if !viewModel.errorMessage.isEmpty{
                            Text(viewModel.errorMessage)
                                .foregroundColor(Color.red)
                        }
                        
                        Text("Email Address")
                            .foregroundColor(ColorPalette.textPrimary)
                            .font(.subheadline)
                        
                        TextField("Enter your email", text: $viewModel.email)
                            .padding()
                            .background(ColorPalette.secondaryBackground)
                            .foregroundColor(ColorPalette.textPrimary)
                            .cornerRadius(8)
                            .autocapitalization(.none)
                            .textInputAutocapitalization(.never)
                            .keyboardType(.emailAddress)
                    }
                    .padding(.horizontal, 40)
                    
                    // Password Field
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Password")
                            .foregroundColor(ColorPalette.textPrimary)
                            .font(.subheadline)
                        
                        ZStack(alignment: .trailing) {
                            if isPasswordVisible {
                                TextField("Enter your password", text: $viewModel.password)
                                    .padding()
                                    .background(ColorPalette.secondaryBackground)
                                    .foregroundColor(ColorPalette.textPrimary)
                                    .cornerRadius(8)
                            } else {
                                SecureField("Enter your password", text: $viewModel.password)
                                    .padding()
                                    .background(ColorPalette.secondaryBackground)
                                    .foregroundColor(ColorPalette.textPrimary)
                                    .cornerRadius(8)
                            }
                            
                            Button(action: {
                                isPasswordVisible.toggle()
                            }) {
                                Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                    .foregroundColor(ColorPalette.textPrimary)
                                    .padding(.trailing, 10)
                            }
                        }
                        HStack {
                            Spacer()
                            Button(action: {
                                // Show forgot password modal
                                isForgotPasswordAlertPresented.toggle()
                            }) {
                                Text("Forgot Password?")
                                    .foregroundColor(ColorPalette.accentColor)
                                    .font(.subheadline)
                            }
                        }
                        .padding(.top, 10)
                    }
                    .padding(.horizontal, 40)
                    
                    Spacer()
                
                    ButtonLogin(title: "Log In", background: ColorPalette.buttonBackground) {
                        // Attempt log in
                        viewModel.login()
                    }
                    .padding()

                    // Or Sign In With
                    Text("or Login in with")
                        .foregroundColor(ColorPalette.textPrimary)
                        .padding(.top, 20)

                    // Social Media Buttons
                    HStack(spacing: 20) {
                        Button(action: {
                            // Google login action
                        }) {
                            Image("google-icon")
                                .resizable()
                                .frame(width: 40, height: 40)
                        }

                        Button(action: {
                            // Facebook login action
                        }) {
                            Image("facebook-icon")
                                .resizable()
                                .frame(width: 40, height: 40)
                        }

                        Button(action: {
                            // Apple login action
                        }) {
                            Image(systemName: "applelogo")
                                .font(.title)
                                .foregroundColor(ColorPalette.textPrimary)
                        }
                    }

                    Spacer()

                    // Sign Up Link
                    HStack {
                        Text("Don't have an account?")
                            .foregroundColor(ColorPalette.textPrimary)

                        NavigationLink(destination: RegisterV()) {
                            Text("Sign Up")
                                .fontWeight(.bold)
                                .foregroundColor(ColorPalette.accentColor)
                        }
                    }
                    .padding(.bottom, 30)
                }
            }
            .navigationBarBackButtonHidden(true) // Hide default back button
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Password Reset"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            .sheet(isPresented: $isForgotPasswordAlertPresented) {
                ForgotPasswordView(resetEmail: $resetEmail, onSubmit: handleForgotPassword)
            }
        }
    }
    
    // Handle forgot password logic
    func handleForgotPassword() {
        Auth.auth().sendPasswordReset(withEmail: resetEmail) { error in
            if let error = error {
                alertMessage = "Error: \(error.localizedDescription)"
            } else {
                alertMessage = "Password reset email sent successfully."
            }
            showAlert = true
            isForgotPasswordAlertPresented = false // Dismiss the sheet after submission
        }
    }
}

struct ForgotPasswordView: View {
    @Binding var resetEmail: String
    var onSubmit: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Enter your email address to reset your password.")
                .font(.headline)
                .padding()
            
            TextField("Email Address", text: $resetEmail)
                .padding()
                .background(Color.black)
                .cornerRadius(8)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
            
            Button("Submit") {
                onSubmit()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .padding()
    }
}

#Preview {
    LoginV()
}

