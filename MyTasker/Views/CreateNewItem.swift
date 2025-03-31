//
//  CreateNewItem.swift
//  MyTasker
//
//  Created by Anushya Jeshtadi on 22/01/2025.
//
//current useing it
import SwiftUI

struct CreateNewItem: View {
    @StateObject var viewModel = CreateNewItemVM()
    @Binding var newItemPresented: Bool

    var body: some View {
        NavigationView {
            Form {
                // Title
                Section(header: Text("Title").foregroundColor(ColorPalette.textPrimary)) {
                    TextField("Write title for your task", text: $viewModel.title)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .foregroundColor(ColorPalette.textPrimary)
                }

                // Description
                Section(header: Text("Description").foregroundColor(ColorPalette.textPrimary)) {
                    TextField("What's your task about? (Optional)", text: $viewModel.description)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .foregroundColor(ColorPalette.textPrimary)
                }

//                Section {
//                    HStack {
//                        TextField("Enter duration", value: $viewModel.duration, format: .number)
//                            .keyboardType(.numberPad)
//                            .textFieldStyle(DefaultTextFieldStyle())
//                            .foregroundColor(ColorPalette.textPrimary)
//                        
//                        Picker("Unit", selection: $viewModel.isMinutesSelected) {
//                            Text("Minutes").tag(true)
//                            Text("Hours").tag(false)
//                        }
//                        .pickerStyle(MenuPickerStyle())
//                    }
//                } header: {
//                    Text("Duration")
//                        .foregroundColor(ColorPalette.textPrimary)
//                }
        
                // Due Date
                Section(header: Text("Due Date").foregroundColor(ColorPalette.textPrimary)) {
                    DatePicker("Select date", selection: $viewModel.dueDate)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .foregroundColor(ColorPalette.textPrimary)
                }

                // Task Color
                Section(header: Text("Task Color").foregroundColor(ColorPalette.textPrimary)) {
                    Picker("Choose a color", selection: $viewModel.selectedColor) {
                        Text("Red").tag("Red")
                        Text("Blue").tag("Blue")
                        Text("Green").tag("Green")
                        Text("Yellow").tag("Yellow")
                        Text("Default").tag("Default")
                    }
                    .pickerStyle(MenuPickerStyle())
                }

                // Repeat Task
                Section(header: Text("Repeat Task").foregroundColor(ColorPalette.textPrimary)) {
                    Picker("Repeat Interval", selection: $viewModel.repeatInterval) {
                        Text("None").tag(nil as TimeInterval?)
                        Text("Daily").tag(86400 as TimeInterval?)
                        Text("Weekly").tag(604800 as TimeInterval?)
                        Text("Monthly").tag(2_592_000 as TimeInterval?)
                    }
                    .pickerStyle(MenuPickerStyle())
                }

                // Notify Before
                Section(header: Text("Notification Alert").foregroundColor(ColorPalette.textPrimary)) {
                    Picker("Notify me before", selection: $viewModel.notifyBefore) {
                        Text("None").tag(nil as TimeInterval?)
                        Text("5 minutes").tag(300 as TimeInterval?)
                        Text("15 minutes").tag(900 as TimeInterval?)
                        Text("30 minutes").tag(1800 as TimeInterval?)
                        Text("1 hour").tag(3600 as TimeInterval?)
                    }
                    .pickerStyle(MenuPickerStyle())
                }

                // Additional Info
//                Section(header: Text("Additional Info").foregroundColor(ColorPalette.textPrimary)) {
//                    TextField("Add links, location, phone number, etc.", text: $viewModel.additionalInfo)
//                        .textFieldStyle(DefaultTextFieldStyle())
//                        .foregroundColor(ColorPalette.textPrimary)
//                }

                // Save Button
                Section {
                    ButtonLogin(title: "Save", background: ColorPalette.buttonBackground) {
                        if viewModel.canSave {
                            viewModel.save()
                            newItemPresented = false
                        } else {
                            viewModel.showAlert = true
                        }
                    }
                    .padding()
                }
            }
            .background(ColorPalette.primaryBackground.ignoresSafeArea())
            .navigationTitle("New Task")
            .navigationBarTitleDisplayMode(.inline)
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Error"), message: Text("Please fill in all fields"))
            }
        }
    }
}

// Preview
#Preview {
    CreateNewItem(newItemPresented: Binding(get: {
        return true
    }, set: { _ in
    }))
}

