//
//  ContentViewVM.swift
//  MyTasker
//
//  Created by Anushya Jeshtadi on 22/01/2025.



import FirebaseAuth
import Foundation
@preconcurrency import GoogleGenerativeAI

class ContentViewVM: ObservableObject {
    @Published var showingNewItemView = false
    @Published var currentUserId: String = ""
    
    private var handler: AuthStateDidChangeListenerHandle?
    private let gemini = GenerativeModel(name: "gemini-pro", apiKey: "YOUR_GEMINI_API_KEY")
    
    init() {
        self.handler = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                self?.currentUserId = user?.uid ?? ""
            }
        }
    }
    
    public var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }

    // **Fixed Placement: Move Function Inside Class**
    func getGeminiResponse(for prompt: String, completion: @escaping (String) -> Void) {
        Task {
            do {
                let response = try await gemini.generateContent(prompt)
                DispatchQueue.main.async {
                    completion(response.text ?? "No response")
                }
            } catch {
                DispatchQueue.main.async {
                    completion("Error: \(error.localizedDescription)")
                }
            }
        }
    }
}
