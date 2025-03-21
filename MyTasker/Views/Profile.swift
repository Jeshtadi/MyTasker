//
//  Profile.swift
//  MyTasker
//
//  Created by Anushya Jeshtadi on 22/01/2025.
//
//working profile
import SwiftUI

struct Profile: View {
    @StateObject var viewModel = ProfileVM()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                if let user = viewModel.user {
                    profile(user: user)
                } else {
                    ProgressView("Loading Profile...")
                        .progressViewStyle(CircularProgressViewStyle(tint: ColorPalette.accentColor))
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(ColorPalette.primaryBackground.ignoresSafeArea())
            .navigationTitle("Profile")
        }
        .onAppear {
            viewModel.fetchUser()
        }
    }
    
    @ViewBuilder
    func profile(user: User) -> some View {
        VStack(spacing: 20) {
            Image(systemName: "person.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 130, height: 130)
                .foregroundColor(ColorPalette.accentColor)
                .shadow(radius: 5)
                
            VStack(alignment: .leading, spacing: 15) {
                infoRow(title: "Name", value: user.name)
                infoRow(title: "Email", value: user.email)
                infoRow(title: "Member Since", value: Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated, time: .omitted))
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(ColorPalette.secondaryBackground)
            .cornerRadius(15)
            .shadow(radius: 5)
            
            Button(action: {
                viewModel.logOut()
            }) {
                Text("Log Out")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(ColorPalette.buttonBackground)
                    .cornerRadius(10)
                    .shadow(radius: 3)
            }
        }
        .padding()
    }
    
    func infoRow(title: String, value: String) -> some View {
        HStack {
            Text("\(title):")
                .font(.headline)
                .foregroundColor(ColorPalette.textPrimary)
            
            Spacer()
            
            Text(value)
                .foregroundColor(ColorPalette.textPrimary)
        }
    }
}

#Preview {
    Profile()
}

