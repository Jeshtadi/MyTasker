//
//  RegisterVVM.swift
//  MyTasker
//
//  Created by Anushya Jeshtadi on 22/01/2025.
//using
//import Firebase
//import FirebaseFirestore
//import FirebaseAuth
//import Foundation
//class RegisterVVM: ObservableObject {
//    @Published  var email: String = ""
//    @Published  var password: String = ""
//    @Published  var confirmPassword: String = ""
//
//    @Published  var name: String = ""
//    @Published  var lastName: String = ""
//    @Published var errorMessage = ""
//    init() {}
//    func register(){
//        guard validate() else{
//            return
//        }
//        
//        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
//            guard let userId = result?.user.uid else {
//            return
//            }
//            self?.insertUserRecord(id: userId)
//            
//        }
//        
//    }
////    part where is adds it the firebase database
////    private func insertUserRecord(id: String) {
////        let newUser = User(id: id,
////                           name: name,
////                           lastName: lastName,
////                           email: email,
////                           joined: Date().timeIntervalSince1970)
////        let db = Firestore.firestore()
////        
////        db.collection("users")
////            .document(id)
////            .setData(newUser.asDictionary())
////    }
//    private func insertUserRecord(id: String) {
//        let newUser = User(
//            id: id,
//            name: name,
//            lastName: lastName,
//            email: email,
//            joined: Date().timeIntervalSince1970
//        )
//        let db = Firestore.firestore()
//        
//        db.collection("users")
//            .document(id)
//            .setData(newUser.asDictionary()) { error in
//                if let error = error {
//                    print("Failed to insert user record: \(error.localizedDescription)")
//                } else {
//                    print("User record successfully added for user ID: \(id)")
//                }
//            }
//    }
//
//    
//    private func validate() -> Bool {
//        errorMessage = ""
//        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
//              !lastName.trimmingCharacters(in: .whitespaces).isEmpty,
//              !email.trimmingCharacters(in: .whitespaces).isEmpty,
//              !password.trimmingCharacters(in: .whitespaces).isEmpty,
//              !confirmPassword.trimmingCharacters(in: .whitespaces).isEmpty else {
//            errorMessage = "Error: One or more fields are empty"
//            return false
//        }
//        guard email.contains( "@" ) && email.contains(".") else{
//            return false
//        }
//        guard password.count >= 8 else{
//            return false
//        }
//        guard password == confirmPassword else {
//            errorMessage = "Error: Password and Confirm Password do not match"
//            return false
//        }
//        return true
//        
//        
//    }
//}
//

import Firebase
import FirebaseFirestore
import FirebaseAuth
import Foundation

class RegisterVVM: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var name: String = ""
    @Published var lastName: String = ""
    @Published var errorMessage = ""

    init() {}

    func register(completion: @escaping (Bool, String?) -> Void) {
        guard validate() else {
            completion(false, errorMessage) // Pass the error message if validation fails
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                self?.errorMessage = "Registration failed: \(error.localizedDescription)"
                completion(false, self?.errorMessage)
                return
            }

            guard let userId = result?.user.uid else {
                self?.errorMessage = "User ID not found"
                completion(false, self?.errorMessage)
                return
            }

            self?.insertUserRecord(id: userId) {
                completion(true, nil) // Pass success with no error
            }
        }
    }

    private func insertUserRecord(id: String, completion: @escaping () -> Void) {
        let newUser = User(
            id: id,
            name: name,
            lastName: lastName,
            email: email,
            joined: Date().timeIntervalSince1970
        )
        let db = Firestore.firestore()

        db.collection("users")
            .document(id)
            .setData(newUser.asDictionary()) { error in
                if let error = error {
                    print("Failed to insert user record: \(error.localizedDescription)")
                    self.errorMessage = "Failed to insert user record"
                } else {
                    print("User record successfully added for user ID: \(id)")
                }
                completion()
            }
    }

    private func validate() -> Bool {
        errorMessage = ""

        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
              !lastName.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty,
              !confirmPassword.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "One or more fields are empty"
            return false
        }

        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Invalid email format"
            return false
        }

        guard password.count >= 8 else {
            errorMessage = "Password must be at least 8 characters"
            return false
        }

        guard password == confirmPassword else {
            errorMessage = "Password and Confirm Password do not match"
            return false
        }

        return true
    }
}

