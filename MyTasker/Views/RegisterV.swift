//
//  RegisterV.swift
//  MyTasker
//
//  Created by Anushya Jeshtadi on 22/01/2025.


import SwiftUI

struct RegisterV: View {
    @StateObject var viewModel = RegisterVVM()
    @State private var isPasswordVisible = false
    @State private var isConfirmPasswordVisible = false
    @State private var registrationSuccessful = false
    @State private var showErrorAlert = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                ColorPalette.primaryBackground
                    .ignoresSafeArea()
                
                VStack(spacing: 40) {
                    Text("Sign Up")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(ColorPalette.textPrimary)
                        .padding(.top, 10)
                    
                    // First Name Field
                    TextField("First Name", text: $viewModel.name)
                        .padding()
                        .background(ColorPalette.secondaryBackground)
                        .foregroundColor(ColorPalette.textPrimary)
                        .cornerRadius(8)
                        .padding(.horizontal, 40)
                        .autocorrectionDisabled()
                    
                    // Last Name Field
                    TextField("Last Name", text: $viewModel.lastName)
                        .padding()
                        .background(ColorPalette.secondaryBackground)
                        .foregroundColor(ColorPalette.textPrimary)
                        .cornerRadius(8)
                        .padding(.horizontal, 40)
                        .autocorrectionDisabled()
                    
                    // Email Field
                    TextField("Email Address", text: $viewModel.email)
                        .padding()
                        .background(ColorPalette.secondaryBackground)
                        .foregroundColor(ColorPalette.textPrimary)
                        .cornerRadius(8)
                        .padding(.horizontal, 40)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                    
                    // Password Field
                    ZStack(alignment: .trailing) {
                        if isPasswordVisible {
                            TextField("Enter your password", text: $viewModel.password)
                                .padding(.trailing, 40)
                                .padding()
                                .background(ColorPalette.secondaryBackground)
                                .foregroundColor(ColorPalette.textPrimary)
                                .cornerRadius(8)
                        } else {
                            SecureField("Enter your password", text: $viewModel.password)
                                .padding(.trailing, 40)
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
                    .padding(.horizontal, 40)
                    
                    // Confirm Password Field
                    ZStack(alignment: .trailing) {
                        if isConfirmPasswordVisible {
                            TextField("Confirm your password", text: $viewModel.confirmPassword)
                                .padding(.trailing, 40)
                                .padding()
                                .background(ColorPalette.secondaryBackground)
                                .foregroundColor(ColorPalette.textPrimary)
                                .cornerRadius(8)
                        } else {
                            SecureField("Confirm your password", text: $viewModel.confirmPassword)
                                .padding(.trailing, 40)
                                .padding()
                                .background(ColorPalette.secondaryBackground)
                                .foregroundColor(ColorPalette.textPrimary)
                                .cornerRadius(8)
                        }
                        Button(action: {
                            isConfirmPasswordVisible.toggle()
                        }) {
                            Image(systemName: isConfirmPasswordVisible ? "eye.slash" : "eye")
                                .foregroundColor(ColorPalette.textPrimary)
                                .padding(.trailing, 10)
                        }
                    }
                    .padding(.horizontal, 40)
                    
                    // Error message
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    }
                    
                    // Sign Up Button
                    ButtonRegister(title: "Sign Up", background: ColorPalette.buttonBackground) {
                        viewModel.register { success, error in
                            if let error = error {
                                // Show the error alert
                                showErrorAlert = true
                                viewModel.errorMessage = error
                            } else if success {
                                registrationSuccessful = true // Trigger navigation
                            }
                        }
                    }
                    
                    Spacer()
                    
                    // Using NavigationLink with value-based navigation
                    NavigationLink(value: registrationSuccessful) {
                        EmptyView()
                    }
                    .navigationDestination(for: Bool.self) { _ in
                        LoginV()
                    }
                    .hidden()
                }
            }
            .alert(isPresented: $showErrorAlert) {
                Alert(
                    title: Text("Registration Failed"),
                    message: Text(viewModel.errorMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
            .navigationBarBackButtonHidden(true) // Hide default back button
        }
    }
}




