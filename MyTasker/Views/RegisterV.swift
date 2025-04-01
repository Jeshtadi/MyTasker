//
//  RegisterV.swift
//  MyTasker
//
//  Created by Anushya Jeshtadi on 22/01/2025.

import SwiftUI

struct RegisterV: View {
//    @State private var email: String = ""
//    @State private var password: String = ""
//    @State private var confirmPassword: String = ""
////    @State private var mobile: String = ""
//    @State private var firstName: String = ""
//    @State private var lastName: String = ""
    @StateObject var viewModel = RegisterVVM()
    @State private var isPasswordVisible = false
    @State private var isConfirmPasswordVisible = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background Color
                ColorPalette.primaryBackground
                    .ignoresSafeArea()
                
                VStack(spacing: 40) {
                    // Back to Login Button
                    //                    NavigationLink(destination: LoginV()) {
                    //                        Text("< Back")
                    //                            .font(.headline)
                    //                            .foregroundColor(ColorPalette.textPrimary)
                    //                            .padding(.top, 20)
                    //                            .padding(.leading, 20)
                    //                            .frame(maxWidth: .infinity, alignment: .leading)
                    //                    }
                    
                    // Sign Up Heading
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
                    //                        .textInputAutocapitalization(.never)
                    
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
                    
                    // Sign Up Button
                    ButtonLogin(title: "Sign Up", background: ColorPalette.buttonBackground) {
                        //                        Attempt registration in
                        viewModel.register()
                    }
                    
                    Spacer()
                }
            }
            .navigationBarBackButtonHidden(true) // Hide default back button
        }
    }
}


#Preview {
    RegisterV()
}
