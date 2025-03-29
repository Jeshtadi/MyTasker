//
//  ContentView.swift
//  MyTasker
//
//  Created by Anushya Jeshtadi on 22/01/2025.
//


//WORKING
//import SwiftUI
//
//struct ContentView: View {
//    @StateObject var viewModel = ContentViewVM()
//   
//    
//    
//    var body: some View {
//        if viewModel.isSignedIn && !viewModel.currentUserId.isEmpty {
//            accountView
//            
//            // Show the view after login
//            
//        } else {
//            // Show the login or welcome screen
//            NavigationView {
//                ZStack {
//                    ColorPalette.primaryBackground
//                        .ignoresSafeArea() // Set the background color
//                    
//                    VStack(spacing: 20) {
//                        Spacer()
//                        
//                        // App Logo
//                        Image(systemName: "app.fill")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 100, height: 100)
//                            .foregroundColor(.accentColor)
//                        
//                        // Welcome Text
//                        Text("Welcome to MyTasker App")
//                            .font(.largeTitle)
//                            .fontWeight(.bold)
//                            .foregroundColor(ColorPalette.textPrimary)
//                            .multilineTextAlignment(.center)
//                            .padding(.horizontal, 20)
//                        
//                        Spacer()
//                        
//                        // Get Started Button
//                        NavigationLink(destination: LoginV()) {
//                            Text("Get Started")
//                                .font(.headline)
//                                .foregroundColor(ColorPalette.textPrimary)
//                                .padding()
//                                .frame(maxWidth: .infinity)
//                                .background(ColorPalette.buttonBackground)
//                                .cornerRadius(8)
//                                .padding(.horizontal)
//                        }
//                    }
//                    .padding()
//                }
//            }
//        }
//    }
////    @ViewBuilder
////    var accountView: some View {
////        TabView{
////            AfterLoginView(userId: viewModel.currentUserId)
////                .tabItem {
////                    Label("Home", systemImage: "house")
////                }
////            Profile()
////                .tabItem{
////                    Label("Profile", systemImage:"person.circle")
////                }
////        }
////        
////    }
////    @ViewBuilder
////    var accountView: some View {
////        TabView {
////            AfterLoginView(userId: viewModel.currentUserId)
////                .tabItem {
////                    Label("Home", systemImage: "house")
////                }
//////            Profile()
//////                .tabItem {
//////                    Label("Profile", systemImage: "person.circle")
//////                }
////            CreateNewItem()
////                .tabItem {
////                   
////                    Label("Add", systemImage: "plus")
////                }
////            CalendarView()
////                .tabItem {
////                    Label("Calendar", systemImage: "calendar")
////                }
////                
////            SettingsView()
////                .tabItem {
////                    Label("Settings", systemImage: "gearshape")
////                }
////        }
////    }
//
//    @ViewBuilder
//    var accountView: some View {
//        TabView {
//            // Home Tab
//            AfterLoginView(userId: viewModel.currentUserId)
//                .tabItem {
//                    Label("Home", systemImage: "house")
//                }
//
//            // Add Tab - Triggers Sheet
//            Color.clear // Placeholder view for the "Add" tab
//                .tabItem {
//                    Label("Add", systemImage: "plus")
//                }
//                .sheet(isPresented: $viewModel.showingNewItemView) {
//                    CreateNewItem(newItemPresented: $viewModel.showingNewItemView) // Sheet for creating a new item
//                }
//                .onAppear {
//                    viewModel.showingNewItemView = true // Automatically triggers the sheet when selected
//                }
//
//            // Calendar Tab
//            CalendarView()
//                .tabItem {
//                    Label("Calendar", systemImage: "calendar")
//                }
//
//            // Settings Tab
//            SettingsView()
//                .tabItem {
//                    Label("Settings", systemImage: "gearshape")
//                }
//        }
//    }
//
//}
//
//#Preview {
//    ContentView()
//}

//
//



//import SwiftUI
////import GoogleGenerativeAI
//
//struct ContentView: View {
//    @StateObject var viewModel = ContentViewVM()
//   
//    
//    
//    var body: some View {
//        if viewModel.isSignedIn && !viewModel.currentUserId.isEmpty {
//            accountView
//            
//            // Show the view after login
//            
//        } else {
//            // Show the login or welcome screen
//            NavigationView {
//                ZStack {
//                    ColorPalette.primaryBackground
//                        .ignoresSafeArea() // Set the background color
//                    
//                    VStack(spacing: 20) {
//                        Spacer()
//                        
//                        // App Logo
//                        Image("appIcon")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 100, height: 100)
//                            .foregroundColor(.accentColor)
//                        
//                        // Welcome Text
//                        Text("Welcome to MyTasker App")
//                            .font(.largeTitle)
//                            .fontWeight(.bold)
//                            .foregroundColor(ColorPalette.textPrimary)
//                            .multilineTextAlignment(.center)
//                            .padding(.horizontal, 20)
//                        
//                        Spacer()
//                        
//                        // Get Started Button
//                        NavigationLink(destination: LoginV()) {
//                            Text("Get Started")
//                                .font(.headline)
//                                .foregroundColor(ColorPalette.textPrimary)
//                                .padding()
//                                .frame(maxWidth: .infinity)
//                                .background(ColorPalette.buttonBackground)
//                                .cornerRadius(8)
//                                .padding(.horizontal)
//                        }
//                    }
//                    .padding()
//                }
//            }
//        }
//    }
//    
//    @ViewBuilder
//    var accountView: some View {
//        NavigationView {
//            TabView {
//                // Home Tab
//                AfterLoginView(userId: viewModel.currentUserId)
//                    .tabItem {
//                        Label("Home", systemImage: "house")
//                    }
//
//                // Add Tab - Navigates to CreateNewItem
//                NavigationLink(
//                    destination: CreateNewItem(newItemPresented: .constant(false)),
//                    label: {
//                        Text("Add New Task")
//                    }
//                )
//                .tabItem {
//                    Label("Add", systemImage: "plus")
//                }
//
//                // Calendar Tab
//                CalendarView()
//                    .tabItem {
//                        Label("Calendar", systemImage: "calendar")
//                    }
//
//                // Settings Tab
//                SettingsView()
//                    .tabItem {
//                        Label("Settings", systemImage: "gearshape")
//                    }
//            }
//            .navigationTitle("MyTasker")
//            .navigationBarTitleDisplayMode(.inline)
//        }
//    }
//
//    
//}
//
//// Preview
//#Preview {
//    ContentView()
//}

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewVM()
    @State private var selectedTab = 0 // Track selected tab
    @State private var isAddingTask = false // Controls the bottom sheet
    
    var body: some View {
        if viewModel.isSignedIn && !viewModel.currentUserId.isEmpty {
            accountView
        } else {
            loginView
        }
    }
    
    // View before login
    var loginView: some View {
        NavigationView {
            VStack(spacing: 20) {
                Spacer()
                
                Image("appIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                
                Text("Welcome to MyTasker App")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                
                Spacer()
                
                NavigationLink(destination: LoginV()) {
                    Text("Get Started")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                }
            }
            .padding()
        }
    }
    
    // View after login
    @ViewBuilder
    var accountView: some View {
        NavigationView {
            TabView(selection: $selectedTab) {
                AfterLoginView(userId: viewModel.currentUserId)
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                    .tag(0)
                
                Color.clear // Placeholder view (not visible)
                    .tabItem {
                        Label("Add", systemImage: "plus")
                    }
                    .tag(1)
                
                CalendarView()
                    .tabItem {
                        Label("Calendar", systemImage: "calendar")
                    }
                    .tag(2)
                
//                GeminiChatView()
//                    .tabItem {
//                        Label("AI Chat", systemImage: "bubble.left.and.bubble.right")
//                    }
//                    .tag(3)
                
                ImportCalendarView()
                    .tabItem {
                        Label("Import", systemImage: "arrow.down.doc")
                    }
                    .tag(4)
                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
                    .tag(5)
            }
            .toolbarBackground(Color.white, for: .navigationBar) // Set navigation bar background color
            .navigationBarTitleDisplayMode(.inline)
            .onChange(of: selectedTab) { oldTab, newTab in
                if newTab == 1 {
                    isAddingTask = true
                    selectedTab = 0
                }
            }
            .sheet(isPresented: $isAddingTask) {
                CreateNewItem(newItemPresented: $isAddingTask)
            }
        }
    }
}
//    var accountView: some View {
//        NavigationView {
//            TabView(selection: $selectedTab) {
//                AfterLoginView(userId: viewModel.currentUserId)
//                    .tabItem {
//                        Label("Home", systemImage: "house")
//                    }
//                    .tag(0)
//                
//                Color.clear // Placeholder view (not visible)
//                    .tabItem {
//                        Label("Add", systemImage: "plus")
//                    }
//                    .tag(1)
//                
//                CalendarView()
//                    .tabItem {
//                        Label("Calendar", systemImage: "calendar")
//                    }
//                    .tag(2)
//                
//                GeminiChatView()
//                    .tabItem {
//                        Label("AI Chat", systemImage: "bubble.left.and.bubble.right")
//                    }
//                    .tag(3)
//                
////                SettingsView()
////                    .tabItem {
////                        Label("Settings", systemImage: "gearshape")
////                    }
////                    .tag(4)
//                ImportCalendarView()
//                    .tabItem {
//                        Label("Import", systemImage: "arrow.down.doc")
//                    }
//                    .tag(4)
//            }
////            .navigationTitle("MyTasker")
//            .navigationBarTitleDisplayMode(.inline)
//            .onChange(of: selectedTab) {oldTab, newTab in
//                if newTab == 1 {
//                    isAddingTask = true
//                    selectedTab = 0
//                }
//            }
//            .sheet(isPresented: $isAddingTask) {
//                CreateNewItem(newItemPresented: $isAddingTask)
//            }
//        }
//    }
//}

// Preview
#Preview {
    ContentView()
}






//WELCOM PAGE DOENT SHOW WHEN LOGGED IN DIDNT CHECK)
//import SwiftUI
//
//struct ContentView: View {
//    @StateObject var viewModel = ContentViewVM()
//    @State private var selectedTab = 0 // Track selected tab
//    @State private var isAddingTask = false // Controls the bottom sheet
//
//    var body: some View {
//        // Show login view only if the user is not signed in
//        if !viewModel.isSignedIn || viewModel.currentUserId.isEmpty {
//            loginView
//        } else {
//            accountView
//        }
//    }
//
//    // View before login
//    var loginView: some View {
//        NavigationView {
//            VStack(spacing: 20) {
//                Spacer()
//                
//                Image("appIcon")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 100, height: 100)
//                
//                Text("Welcome to MyTasker App")
//                    .font(.largeTitle)
//                    .fontWeight(.bold)
//                    .multilineTextAlignment(.center)
//                    .padding(.horizontal, 20)
//                
//                Spacer()
//                
//                NavigationLink(destination: LoginV()) {
//                    Text("Get Started")
//                        .font(.headline)
//                        .padding()
//                        .frame(maxWidth: .infinity)
//                        .background(Color.blue)
//                        .cornerRadius(8)
//                        .foregroundColor(.white)
//                        .padding(.horizontal)
//                }
//            }
//            .padding()
//        }
//    }
//
//    // View after login
//    @ViewBuilder
//    var accountView: some View {
//        NavigationView {
//            TabView(selection: $selectedTab) {
//                AfterLoginView(userId: viewModel.currentUserId)
//                    .tabItem {
//                        Label("Home", systemImage: "house")
//                    }
//                    .tag(0)
//
//                Color.clear // Placeholder view (not visible)
//                    .tabItem {
//                        Label("Add", systemImage: "plus")
//                    }
//                    .tag(1)
//
//                CalendarView()
//                    .tabItem {
//                        Label("Calendar", systemImage: "calendar")
//                    }
//                    .tag(2)
//
//                GeminiChatView()
//                    .tabItem {
//                        Label("AI Chat", systemImage: "bubble.left.and.bubble.right")
//                    }
//                    .tag(3)
//
//                SettingsView()
//                    .tabItem {
//                        Label("Settings", systemImage: "gearshape")
//                    }
//                    .tag(4)
//                
//                ImportCalendarView()
//                    .tabItem {
//                        Label("Import", systemImage: "arrow.down.doc")
//                    }
//                    .tag(5)
//            }
//            .navigationBarTitleDisplayMode(.inline)
//            .onChange(of: selectedTab) { oldTab, newTab in
//                if newTab == 1 {
//                    isAddingTask = true
//                    selectedTab = 0
//                }
//            }
//            .sheet(isPresented: $isAddingTask) {
//                CreateNewItem(newItemPresented: $isAddingTask)
//            }
//        }
//    }
//}
//
//// Preview
//#Preview {
//    ContentView()
//}

