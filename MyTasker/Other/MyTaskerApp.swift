//
//  MyTaskerApp.swift
//  MyTasker
//
//  Created by Anushya Jeshtadi on 22/01/2025.

import SwiftUI
import Firebase

@main
struct MyTaskerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

//class AppDelegate: NSObject, UIApplicationDelegate {
//    func application(
//        _ application: UIApplication,
//        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//    ) -> Bool {
//        // Configure Firebase
//        FirebaseApp.configure()
//
//        // Reset hideCheckmarkMessage every app launch
//        UserDefaults.standard.set(false, forKey: "hideCheckmarkMessage")
//
//        return true
//    }
//}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Configure Firebase
        FirebaseApp.configure()

        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("Notification permission granted.")
            } else {
                print("Notification permission denied.")
            }
        }

        UserDefaults.standard.set(false, forKey: "hideCheckmarkMessage")

        return true
    }
}


