//
//  LoginVVm.swift
//  MyTasker
//
//  Created by Anushya Jeshtadi on 22/01/2025.
//
import FirebaseAuth
import Foundation
class LoginVVm: ObservableObject{
    @Published  var email: String = ""
    @Published  var password: String = ""
    @Published var errorMessage = ""
    @Published var successMessage = ""
    init() {}
    
    func login() {
        guard validate() else {
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (result, error) in
            if let error = error as NSError? {
                print("Error code: \(error.code)")
                
                switch error.code {
                case AuthErrorCode.userNotFound.rawValue:
                    self?.errorMessage = "No account found with this email."
                case AuthErrorCode.wrongPassword.rawValue:
                    self?.errorMessage = "Incorrect password. Please try again."
                case AuthErrorCode.invalidEmail.rawValue:
                    self?.errorMessage = "The email address is invalid."
                case AuthErrorCode.networkError.rawValue:
                    self?.errorMessage = "Network error. Please try again later."
                default:
                    self?.errorMessage = error.localizedDescription
                }
            } else {
                self?.errorMessage = ""
            }
        }
    }
    
    private func validate() -> Bool {
        errorMessage = ""
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else{
            errorMessage = "Please fill in all fields"
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Invalid email format"
            return false
        }
        return true
        
    }
    
    func sendPasswordResetEmail() {
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty else {
            self.errorMessage = "Please enter your email."
            return
        }
        
        Auth.auth().sendPasswordReset(withEmail: email) { [weak self] error in
            if let error = error {
                self?.errorMessage = error.localizedDescription
            } else {
                self?.successMessage = "A password reset email has been sent to your email."
            }
        }
    }
}

