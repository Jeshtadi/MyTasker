//
//  GeminiChatView.swift
//  MyTasker
//
//  Created by Anushya Jeshtadi on 10/02/2025.
//

//import Foundation
import SwiftUI
import Combine
import GoogleGenerativeAI

struct GeminiChatView: View {
    let model = GenerativeModel(name: "gemini-2.0-flash", apiKey: APIKey.default)
    @State private var textInput = ""
    @State private var aiResponse = "Hello! How can I help you today?"
    @State private var logoAnimating = false
    @State private var timer: Timer?

    var body: some View {
        VStack {
           
        
            ScrollView {
                Text(aiResponse)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .padding()
            }

            // MARK: - Input Fields
            HStack {
                

                TextField("Enter a message", text: $textInput)
                    .textFieldStyle(.roundedBorder)
                    .foregroundColor(.white)

                Button(action: sendMessage) {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.blue)
                        .padding()
                }
            }
            .padding()
        }
        .foregroundColor(.white)
        .padding()
        .background {
            // MARK: - Background
            Color.black.ignoresSafeArea()
        }
    }

    // MARK: - Fetch AI Response
    func sendMessage() {
        aiResponse = ""
        startLoadingAnimation()

        Task {
            do {
                let response = try await model.generateContent([textInput])

                
                stopLoadingAnimation()

                guard let text = response.text else {
                    aiResponse = "Sorry, I could not process that.\nPlease try again."
                    return
                }
                
                textInput = ""
                aiResponse = text
                
            } catch {
                stopLoadingAnimation()
                aiResponse = "Something went wrong!\n\(error.localizedDescription)"
            }
        }
    }

    // MARK: - Loading Animation
    func startLoadingAnimation() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            logoAnimating.toggle()
        }
    }

    func stopLoadingAnimation() {
        logoAnimating = false
        timer?.invalidate()
        timer = nil
    }
}

// Preview
#Preview {
    GeminiChatView()
}
