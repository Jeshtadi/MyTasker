//
//  ToDoListitems.swift
//  MyTasker
//
//  Created by Anushya Jeshtadi on 22/01/2025.




//like working
import SwiftUI

struct ToDoListitems: View {
    @StateObject var viewModel = ToDoListItemsVM()
    let item: ToDoListitem

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Title (Bold and Larger)
            Text(item.title)
                .font(.headline)
                .bold()
                .foregroundColor(.black)
            
            // Description
            Text(item.description ?? "No description available")
                .font(.subheadline)
                .foregroundColor(.black.opacity(0.8))
            
            Divider()
                .background(Color.black.opacity(0.5))
            
            // Additional Task Info
            VStack(alignment: .leading, spacing: 5) {
                Text("Due: \(Date(timeIntervalSince1970: item.dueDate).formatted(date: .abbreviated, time: .shortened))")
                
                Text("Created: \(Date(timeIntervalSince1970: item.createDate).formatted(date: .abbreviated, time: .shortened))")
                
                if let durationInSeconds = item.duration {
                    let hours = Int(durationInSeconds) / 60
                    let minutes = (Int(durationInSeconds) % 60)
                    
                    if hours > 0 {
                        Text("Duration: \(hours) hour\(hours > 1 ? "s" : "") \(minutes > 0 ? "\(Int(minutes)) minute\(minutes > 1 ? "s" : "")" : "")")
                        } else {
                            Text("Duration: \(Int(minutes)) minute\(minutes > 1 ? "s" : "")")
                        }
                    }

            
                if let notifyBefore = item.notifyBefore {
                    let minutes = Int(notifyBefore) / 60  // Convert from seconds to minutes
                        
                    if minutes < 60 {
                        Text("Notify Before: \(minutes) minute\(minutes > 1 ? "s" : "")")  // Handle plural
                    } else {
                        let hours = minutes / 60
                        Text("Notify Before: \(hours) hour\(hours > 1 ? "s" : "")")  // Handle plural
                    }
                }
                    
                if let repeatInterval = item.repeatInterval, repeatInterval > 0 {
                    let intervalInDays = Int(repeatInterval) / 86400  // Convert seconds to days
                    
                    let weeks = intervalInDays / 7
                    let months = intervalInDays / 30
                    
                    if months > 0 {
                        Text("Notify Every: \(months) month\(months > 1 ? "s" : "")")
                    } else if weeks > 0 {
                        Text("Notify Every: \(weeks) week\(weeks > 1 ? "s" : "")")
                    } else {
                        Text("Notify Every: \(intervalInDays) day\(intervalInDays > 1 ? "s" : "")")
                    }
                }
            }
            .font(.footnote)
            .foregroundColor(.black.opacity(0.9))
            
            // Task Completion Button
            HStack {
                Spacer()
                Button {
                    viewModel.toggleIsDone(item: item)
                } label: {
                    Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(.black)
                        .font(.title2)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(viewModel.getTaskColor(for: item.color))
        )
        .padding(.horizontal)
    }
}

extension ToDoListItemsVM {
    func getTaskColor(for colorName: String?) -> Color {
        switch colorName {
        case "Red": return .red
        case "Blue": return .blue
        case "Green": return .green
        case "Yellow": return .yellow
        default: return .gray // Default color
        }
    }
}

#Preview {
    ToDoListitems(item: .init(
        id: "123",
        title: "Get milk",
        description: "Buy 2 liters of milk",
        dueDate: Date().timeIntervalSince1970,
        createDate: Date().timeIntervalSince1970,
        duration: 3600,
        isDone: false,
        color: "Blue",
        repeatInterval: 86400, // 1 day
        notifyBefore: 1800 // 30 minutes
    ))
}
