//
//  LoginV.swift
//  MyTasker
//
//  Created by Anushya Jeshtadi on 22/01/2025.
//

//import SwiftUI
//
////struct LoginV: View {
////    var body: some View {
////        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
////    }
////}
//
//struct LoginV: View {
//    var body: some View {
//        ZStack {
//            Color.secondaryBackground
//                .ignoresSafeArea() // Set the background color
//            
//            Text("Login Page")
//                .foregroundColor(.textPrimary)
//                .font(.largeTitle)
//                .fontWeight(.bold)
//        }
//    }
//}
//#Preview {
//    LoginV()
//}
//import SwiftUI
//
//
//struct LoginV: View {
//    @State private var email: String = ""
//    @State private var password: String = ""
//    @State private var isSignUpPresented = false
//    @State private var isForgotPasswordPresented = false
//
//    var body: some View {
//        ZStack {
//            Color.secondaryBackground
//                .ignoresSafeArea()
//            
//            VStack(spacing: 20) {
//                // Title
//                Text("Login")
//                    .foregroundColor(.textPrimary)
//                    .font(.largeTitle)
//                    .fontWeight(.bold)
//                    .padding(.bottom, 20)
//                
//                // Email Field
//                TextField("Email", text: $email)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .keyboardType(.emailAddress)
//                    .autocapitalization(.none)
//                    .padding()
//                    .background(Color.accentColor)
//                    .cornerRadius(10)
//                    .padding(.horizontal)
//                
//                // Password Field
//                SecureField("Password", text: $password)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .padding()
//                    .background(Color.accentColor)
//                    .cornerRadius(10)
//                    .padding(.horizontal)
//                
//                // Forgot Password Button
//                Button(action: {
//                    isForgotPasswordPresented.toggle()
//                }) {
//                    Text("Forgot Password?")
//                        .font(.footnote)
//                        .foregroundColor(.buttonBackground)
//                }
//                .sheet(isPresented: $isForgotPasswordPresented) {
//                    // Forgot password content
//                    Text("Forgot Password Page")
//                }
//                
//                // Login Button
//                Button(action: {
//                    // Perform login action here
//                    print("Login button pressed")
//                }) {
//                    Text("Login")
//                        .frame(maxWidth: .infinity)
//                        .padding()
//                        .background(Color.buttonBackground)
//                        .foregroundColor(.textPrimary)
//                        .cornerRadius(10)
//                        .padding(.horizontal)
//                }
//                
//                // OR Divider
//                HStack {
//                    Rectangle()
//                        .frame(height: 1)
//                        .foregroundColor(.textSecondary)
//                    Text("OR")
//                        .foregroundColor(.textSecondary)
//                        .padding(.horizontal)
//                    Rectangle()
//                        .frame(height: 1)
//                        .foregroundColor(.textSecondary)
//                }
//                .padding(.horizontal)
//                
//                // Social Login Buttons
//                HStack(spacing: 15) {
//                    SocialLoginButton(icon: "google", label: "Google")
//                    SocialLoginButton(icon: "facebook", label: "Facebook")
//                    SocialLoginButton(icon: "applelogo", label: "Apple")
//                }
//                .padding(.horizontal)
//                
//                // Sign Up Button
//                Spacer()
//                Button(action: {
//                    isSignUpPresented.toggle()
//                }) {
//                    Text("Don't have an account? Sign Up")
//                        .foregroundColor(.buttonBackground)
//                }
//                .sheet(isPresented: $isSignUpPresented) {
//                    // Sign-up content
//                    Text("Sign Up Page")
//                }
//            }
//            .padding()
//        }
//    }
//}
//
//struct SocialLoginButton: View {
//    let icon: String
//    let label: String
//
//    var body: some View {
//        Button(action: {
//            // Perform social login action here
//            print("\(label) login pressed")
//        }) {
//            HStack {
//                Image(systemName: icon)
//                Text(label)
//                    .font(.headline)
//            }
//            .frame(maxWidth: .infinity)
//            .padding()
//            .background(Color.accentColor)
//            .foregroundColor(.textPrimary)
//            .cornerRadius(10)
//        }
//    }
//}
//
//#Preview {
//    LoginV()
//}
//import SwiftUI
//
//struct LoginV: View {
//    @State  var email: String = ""
//    @State  var password: String = ""
//    var body: some View {
//        NavigationStack {
//            ZStack {
//                // Background Color
//                ColorPalette.primaryBackground
//                    .ignoresSafeArea()
//                
//                VStack(spacing: 40) {
//                    // Title
//                    Text("Welcome Back")
//                        .font(.largeTitle)
//                        .fontWeight(.bold)
//                        .foregroundColor(ColorPalette.textPrimary)
//                        .padding(.top, 60)
//                   // Email
//                    TextField("Email Address", text: $email)
//                        .padding()
//                        .background(ColorPalette.secondaryBackground)
//                        .foregroundColor(ColorPalette.textPrimary) // Text color
//                        .cornerRadius(8)
//                        .padding(.horizontal, 40)
//                        .keyboardType(.emailAddress)
//                        .autocapitalization(.none)
//                        .textInputAutocapitalization(.never)
//    
//                                        
//                    // Password Field
//                    SecureField("Password", text: $password)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                        .padding()
////                        .background(ColorPalette.secondaryBackground)
////                        .foregroundColor(ColorPalette.textPrimary)
//                        .cornerRadius(8)
//                        .padding(.horizontal, 40)
//                    
//                
//
//                    
//                    // Forgot Password?
//                    Button(action: {
//                        // Action for Forgot Password
//                    }) {
//                        Text("Forgot Password?")
//                            .font(.subheadline)
//                            .foregroundColor(ColorPalette.accentColor)
//                    }
//                    
//                    // Sign In Button
//                    Button(action: {
//                        // Action for Login
//                    }) {
//                        Text("Sign In")
//                            .font(.headline)
//                            .foregroundColor(ColorPalette.primaryBackground)
//                            .padding()
//                            .frame(maxWidth: .infinity)
//                            .background(ColorPalette.buttonBackground)
//                            .cornerRadius(8)
//                            .padding(.horizontal, 40)
//                    }
//                    
//                    // Or Sign In With
//                    Text("Or Sign In With")
//                        .foregroundColor(ColorPalette.textPrimary)
//                        .padding(.top, 20)
//                    
//                    // Social Media Buttons
//                    HStack(spacing: 20) {
//                        // Google Button
//                        Button(action: {
//                            // Action for Google Login
//                        }) {
//                            Image("google-icon") // Use your Google logo image
//                                .resizable()
//                                .frame(width: 40, height: 40)
//                        }
//                        
//                        // Facebook Button
//                        Button(action: {
//                            // Action for Facebook Login
//                        }) {
//                            Image("facebook-icon") // Use your Facebook logo image
//                                .resizable()
//                                .frame(width: 40, height: 40)
//                        }
//                        
//                        // Apple Button
//                        Button(action: {
//                            // Action for Apple Login
//                        }) {
//                            Image(systemName: "applelogo") // SF Symbol for Apple logo
//                                .font(.title)
//                                .foregroundColor(ColorPalette.textPrimary)
//                                .frame(width: 40, height: 40)
//                        }
//                    }
//                    
//                    Spacer()
//                    
//                    // Sign Up
//                    HStack {
//                        Text("Don't have an account?")
//                            .foregroundColor(ColorPalette.textPrimary)
//                        NavigationLink(destination: RegisterV()) {
//                            Text("Sign Up")
//                                .fontWeight(.bold)
//                                .foregroundColor(ColorPalette.accentColor)
//                        }
//                    }
//                    .padding(.bottom, 30)
//                }
//            }
//        }
//    }
//}
//
//#Preview {
//    LoginV()
//}


//import SwiftUI
//
//struct LoginView: View {
//    @State private var email: String = ""
//    @State private var password: String = ""
//    @State private var isPasswordVisible: Bool = false
//    
//    var body: some View {
//        NavigationStack {
//            ZStack {
//                // Background Color
//                ColorPalette.primaryBackground
//                    .ignoresSafeArea()
//                
//                VStack(spacing: 20) {
//                    // Title
//                    Text("Welcome Back")
//                        .font(.largeTitle)
//                        .fontWeight(.bold)
//                        .foregroundColor(ColorPalette.textPrimary)
//                        .padding(.top, 60)
//                    
//                    // Email Field
//                    VStack(alignment: .leading) {
//                        Text("Email Address")
//                            .foregroundColor(ColorPalette.textPrimary)
//                            .font(.subheadline)
//                        
//                        TextField("Enter your email", text: $email)
//                            .padding()
//                            .background(ColorPalette.secondaryBackground)
//                            .foregroundColor(ColorPalette.textPrimary)
//                            .cornerRadius(8)
//                            .autocapitalization(.none)
//                            .textInputAutocapitalization(.never)
//                            .keyboardType(.emailAddress)
//                    }
//                    .padding(.horizontal, 40)
//                    
//                    // Password Field
//                    VStack(alignment: .leading) {
//                        Text("Password")
//                            .foregroundColor(ColorPalette.textPrimary)
//                            .font(.subheadline)
//                        
//                        HStack {
//                            if isPasswordVisible {
//                                TextField("Enter your password", text: $password)
//                                    .padding()
//                                    .background(ColorPalette.secondaryBackground)
//                                    .foregroundColor(ColorPalette.textPrimary)
//                                    .cornerRadius(8)
//                            } else {
//                                SecureField("Enter your password", text: $password)
//                                    .padding()
//                                    .background(ColorPalette.secondaryBackground)
//                                    .foregroundColor(ColorPalette.textPrimary)
//                                    .cornerRadius(8)
//                            }
//                            
//                            Button(action: {
//                                isPasswordVisible.toggle()
//                            }) {
//                                Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
//                                    .foregroundColor(ColorPalette.textPrimary)
//                            }
//                        }
//                    }
//                    .padding(.horizontal, 40)
//                    
//                    // Forgot Password
//                    Button(action: {
//                        // Forgot password action
//                    }) {
//                        Text("Forgot Password?")
//                            .foregroundColor(ColorPalette.accentColor)
//                            .font(.subheadline)
//                    }
//                    
//                    // Sign In Button
//                    Button(action: {
//                        // Sign in action
//                    }) {
//                        Text("Sign In")
//                            .font(.headline)
//                            .foregroundColor(ColorPalette.primaryBackground)
//                            .padding()
//                            .frame(maxWidth: .infinity)
//                            .background(ColorPalette.buttonBackground)
//                            .cornerRadius(8)
//                            .padding(.horizontal, 40)
//                    }
//                    
//                    // Or Sign In With
//                    Text("Or Sign In With")
//                        .foregroundColor(ColorPalette.textPrimary)
//                        .padding(.top, 20)
//                    
//                    // Social Media Buttons
//                    HStack(spacing: 20) {
//                        Button(action: {
//                            // Google login action
//                        }) {
//                            Image("google-icon")
//                                .resizable()
//                                .frame(width: 40, height: 40)
//                        }
//                        
//                        Button(action: {
//                            // Facebook login action
//                        }) {
//                            Image("facebook-icon")
//                                .resizable()
//                                .frame(width: 40, height: 40)
//                        }
//                        
//                        Button(action: {
//                            // Apple login action
//                        }) {
//                            Image(systemName: "applelogo")
//                                .font(.title)
//                                .foregroundColor(ColorPalette.textPrimary)
//                        }
//                    }
//                    
//                    Spacer()
//                    
//                    // Sign Up Link
//                    HStack {
//                        Text("Don't have an account?")
//                            .foregroundColor(ColorPalette.textPrimary)
//                        
//                        NavigationLink(destination: RegisterV()) {
//                            Text("Sign Up")
//                                .fontWeight(.bold)
//                                .foregroundColor(ColorPalette.accentColor)
//                        }
//                    }
//                    .padding(.bottom, 30)
//                }
//            }
//        }
//    }
//}
//
//#Preview {
//    LoginView()



//}
//import SwiftUI
//
//struct LoginV: View {
//    @StateObject var viewModel = LoginVVm()
////    @State private var email: String = ""
////    @State private var password: String = ""
//    @State private var isPasswordVisible: Bool = false
//    
//    var body: some View {
//        NavigationStack {
//            ZStack {
//                // Background Color
//                ColorPalette.primaryBackground
//                    .ignoresSafeArea()
//                
//                VStack(spacing: 20) {
//                    // Title
//                    Text("Welcome Back")
//                        .font(.largeTitle)
//                        .fontWeight(.bold)
//                        .foregroundColor(ColorPalette.textPrimary)
//                        .padding(.top, 60)
//                    
//                    // Email Field
//                    VStack(alignment: .leading, spacing: 5) {
//                        
//                        if !viewModel.errorMessage.isEmpty{
//                            Text(viewModel.errorMessage)
//                                .foregroundColor(Color.red)
//                        }
//                        
//                        Text("Email Address")
//                            .foregroundColor(ColorPalette.textPrimary)
//                            .font(.subheadline)
//                        
//                        TextField("Enter your email", text: $viewModel.email)
//                            .padding()
//                            .background(ColorPalette.secondaryBackground)
//                            .foregroundColor(ColorPalette.textPrimary)
//                            .cornerRadius(8)
//                            .autocapitalization(.none)
//                            .textInputAutocapitalization(.never)
//                            .keyboardType(.emailAddress)
//                    }
//                    .padding(.horizontal, 40)
//                    
//                    // Password Field
//                    VStack(alignment: .leading, spacing: 5) {
//                        Text("Password")
//                            .foregroundColor(ColorPalette.textPrimary)
//                            .font(.subheadline)
//                        
//                        ZStack(alignment: .trailing) {
//                            if isPasswordVisible {
//                                TextField("Enter your password", text: $viewModel.password)
//                                    .padding()
//                                    .background(ColorPalette.secondaryBackground)
//                                    .foregroundColor(ColorPalette.textPrimary)
//                                    .cornerRadius(8)
//                            } else {
//                                SecureField("Enter your password", text: $viewModel.password)
//                                    .padding()
//                                    .background(ColorPalette.secondaryBackground)
//                                    .foregroundColor(ColorPalette.textPrimary)
//                                    .cornerRadius(8)
//                            }
//                            
//                            Button(action: {
//                                isPasswordVisible.toggle()
//                            }) {
//                                Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
//                                    .foregroundColor(ColorPalette.textPrimary)
//                                    .padding(.trailing, 10)
//                            }
//                        }
//                        HStack {
//                            Spacer()
//                            Button(action: {
//                                
//                            }) {
//                                Text("Forgot Password?")
//                                    .foregroundColor(ColorPalette.accentColor)
//                                    .font(.subheadline)
//                            }
//                        }
//                        .padding(.top, 10)
//                    }
//                    .padding(.horizontal, 40)
//                    Spacer()
//                
//
//                    ButtonLogin(title: "Log In", background: ColorPalette.buttonBackground) {
////                        Attempt log in
//                        viewModel.login()
//                    }
//                    .padding()
//
//
//                    // Or Sign In With
//                    Text("or Login in with")
//                        .foregroundColor(ColorPalette.textPrimary)
//                        .padding(.top, 20)
//
//                    // Social Media Buttons
//                    HStack(spacing: 20) {
//                        Button(action: {
//                            // Google login action
//                        }) {
//                            Image("google-icon")
//                                .resizable()
//                                .frame(width: 40, height: 40)
//                        }
//
//                        Button(action: {
//                            // Facebook login action
//                        }) {
//                            Image("facebook-icon")
//                                .resizable()
//                                .frame(width: 40, height: 40)
//                        }
//
//                        Button(action: {
//                            // Apple login action
//                        }) {
//                            Image(systemName: "applelogo")
//                                .font(.title)
//                                .foregroundColor(ColorPalette.textPrimary)
//                        }
//                    }
//
//                    Spacer()
//
//                    // Sign Up Link
//                    HStack {
//                        Text("Don't have an account?")
//                            .foregroundColor(ColorPalette.textPrimary)
//
//                        NavigationLink(destination: RegisterV()) {
//                            Text("Sign Up")
//                                .fontWeight(.bold)
//                                .foregroundColor(ColorPalette.accentColor)
//                        }
//                    }
//                    .padding(.bottom, 30)
//                }
//            }
//            .navigationBarBackButtonHidden(true) // Hide default back button
//        }
//    }
//}
//
//#Preview {
//    LoginV()
//}



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

