//
//  ProfileVM.swift
//  MyTasker
//
//  Created by Anushya Jeshtadi on 22/01/2025.
//
//import FirebaseAuth
//import FirebaseFirestore
//import Foundation
//class ProfileVM: ObservableObject {
//    init(){}
//    @Published var user: User? = nil
//    
//    func fetchUser(){
//        guard let userId = Auth.auth().currentUser?.uid else{
//            return
//        }
//        let db = Firestore.firestore()
//        db.collection("users").document(userId).getDocument {[weak self] snapshot, error in
//            guard let data = snapshot?.data(), error == nil else{
//            return
//        }
//            DispatchQueue.main.async{
//                self?.user = User(
//                    id: data["id"] as? String ?? "",
//                    name: data["name"] as? String ?? "",
//                    lastName: data["lastName"] as? String ?? "",
//                    email: data["email"] as? String ?? "",
//                    joined: data["joined"] as? TimeInterval ?? 0)
//                
//            }
//            
//        }
//    }
//    
//    func logOut(){
//        do {
//            try Auth.auth().signOut()
//            
//        }catch{
//            print(error)
//        }
//        
//    }
//    
//}

//import Foundation
//import FirebaseAuth
//import FirebaseFirestore
//
//class ProfileVM: ObservableObject {
//    @Published var user: User? // User object to hold profile data
//    
//    func fetchUser() {
//        guard let uId = Auth.auth().currentUser?.uid else {
//            print("No user is logged in.")
//            return
//        }
//        
//        let db = Firestore.firestore()
//        db.collection("users").document(uId).getDocument { document, error in
//            if let error = error {
//                print("Error fetching user: \(error.localizedDescription)")
//                return
//            }
//            
//            guard let data = document?.data() else {
//                print("No data found for user.")
//                return
//            }
//            
//            do {
//                // Decode Firestore data into User model
//                let jsonData = try JSONSerialization.data(withJSONObject: data)
//                let fetchedUser = try JSONDecoder().decode(User.self, from: jsonData)
//                DispatchQueue.main.async {
//                    self.user = fetchedUser
//                }
//            } catch {
//                print("Error decoding user data: \(error.localizedDescription)")
//            }
//        }
//    }
//    
//    
//   
//    
//    func logOut() {
//        do {
//            try Auth.auth().signOut()
//            DispatchQueue.main.async {
//                self.user = nil
//            }
//        } catch {
//            print("Error logging out: \(error.localizedDescription)")
//        }
//    }
//}


import Foundation
import FirebaseAuth
import FirebaseFirestore

class ProfileVM: ObservableObject {
    @Published var user: User?

    private let db = Firestore.firestore()
    
    init() {
        fetchUser()
    }

    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        db.collection("users").document(uid).getDocument { snapshot, error in
            guard let data = snapshot?.data(), error == nil else { return }
            
            DispatchQueue.main.async {
                self.user = User(
                    id: uid,
                    name: data["name"] as? String ?? "",
                    lastName: data["lastName"] as? String ?? "",
                    email: data["email"] as? String ?? "",
                    joined: data["joined"] as? TimeInterval ?? 0
                )
            }
        }
    }

    func updateUserInfo(firstName: String, lastName: String) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        db.collection("users").document(uid).updateData([
            "name": firstName,
            "lastName": lastName
        ]) { error in
            if let error = error {
                print("Error updating user info: \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    self.user?.name = firstName
                    self.user?.lastName = lastName
                }
            }
        }
    }

    func updateEmail(newEmail: String) {
        guard let currentUser = Auth.auth().currentUser else { return }
        
        currentUser.updateEmail(to: newEmail) { error in
            if let error = error {
                print("Error updating email: \(error.localizedDescription)")
            } else {
                self.db.collection("users").document(currentUser.uid).updateData([
                    "email": newEmail
                ]) { error in
                    if let error = error {
                        print("Error updating email in Firestore: \(error.localizedDescription)")
                    } else {
                        DispatchQueue.main.async {
                            self.user?.email = newEmail
                        }
                    }
                }
            }
        }
    }

    func updatePassword(newPassword: String, currentPassword: String, completion: @escaping (String?) -> Void) {
        guard let currentUser = Auth.auth().currentUser, let email = currentUser.email else {
            completion("User not found")
            return
        }

        let credential = EmailAuthProvider.credential(withEmail: email, password: currentPassword)

        // Re-authenticate the user
        currentUser.reauthenticate(with: credential) { authResult, error in
            if let error = error {
                completion("Re-authentication failed: \(error.localizedDescription)")
            } else {
                // Proceed with password update
                currentUser.updatePassword(to: newPassword) { error in
                    if let error = error {
                        completion("Error updating password: \(error.localizedDescription)")
                    } else {
                        completion(nil) // Success
                    }
                }
            }
        }
    }
    
    func deleteAccount(currentPassword: String, completion: @escaping (Error?) -> Void) {
            guard let user = Auth.auth().currentUser else {
                print("No user is signed in.")
                completion(NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "User not signed in."]))
                return
            }

            // Ensure email is available
            guard let email = user.email else {
                print("User email not found.")
                completion(NSError(domain: "", code: 402, userInfo: [NSLocalizedDescriptionKey: "Email not found."]))
                return
            }

            // Re-authenticate
            let credential = EmailAuthProvider.credential(withEmail: email, password: currentPassword)
            user.reauthenticate(with: credential) { authResult, error in
                if let error = error {
                    print("Re-authentication failed: \(error.localizedDescription)")
                    completion(error)
                    return
                }

                // Delete Firestore user data
                let db = Firestore.firestore()
                db.collection("users").document(user.uid).delete { error in
                    if let error = error {
                        print("Error deleting user data: \(error.localizedDescription)")
                    } else {
                        print("User data deleted successfully")
                    }
                }

                // Delete Firebase user
                user.delete { error in
                    if let error = error {
                        print("Error deleting account: \(error.localizedDescription)")
                        completion(error)
                    } else {
                        print("Account deleted successfully")
                        completion(nil)
                    }
                }
            }
        }
    
    

    func logOut() {
        do {
            try Auth.auth().signOut()
            DispatchQueue.main.async {
                self.user = nil
            }
        } catch {
            print("Error logging out: \(error.localizedDescription)")
        }
    }
}
