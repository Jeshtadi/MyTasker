//
//  MyTaskerApp.swift
//  MyTasker
//
//  Created by Anushya Jeshtadi on 22/01/2025.
//
//import FirebaseCore
//import SwiftUI
//
//@main
//struct MyTaskerApp: App {
//    init(){
//        FirebaseApp.configure()
//    }
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//    }
//}

//@main
//class AppDelegate: UIResponder, UIApplicationDelegate {
//    func application(_ application: UIApplication,
//                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        FirebaseApp.configure()
//        return true
//    }
//}
import SwiftUI
import Firebase

@main
struct MyTaskerApp: App {
    // Use AppDelegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Configure Firebase
        FirebaseApp.configure()

        // Reset hideCheckmarkMessage every app launch
        UserDefaults.standard.set(false, forKey: "hideCheckmarkMessage")

        return true
    }
}

