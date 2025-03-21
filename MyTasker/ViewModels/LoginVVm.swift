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
        guard validate() else{
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password)
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
    
    func forgotPassword() {
            errorMessage = ""
            successMessage = ""
            
            guard !email.trimmingCharacters(in: .whitespaces).isEmpty else {
                errorMessage = "Please enter your email."
                return
            }
            
            guard email.contains("@") && email.contains(".") else {
                errorMessage = "Invalid email format."
                return
            }
            
            // Send password reset email
            Auth.auth().sendPasswordReset(withEmail: email) { error in
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    self.successMessage = ""
                } else {
                    self.successMessage = "A password reset link has been sent to your email."
                    self.errorMessage = ""
                }
            }
        }
        
    }

