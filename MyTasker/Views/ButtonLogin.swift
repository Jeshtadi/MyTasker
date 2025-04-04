//
//  ButtonLogin.swift
//  MyTasker
//
//  Created by Anushya Jeshtadi on 24/01/2025.
//

import SwiftUI

struct ButtonLogin: View {
    let title: String
    let background: Color
    let action: () -> Void
    
    var body: some View {
        Button {
            action()  // Trigger the action passed to the Button
        } label: {
            Text(title)  // Use the passed `title` here
                .font(.headline)
                .foregroundColor(ColorPalette.textPrimary)
                .padding()
                .frame(maxWidth: .infinity)
                .background(background)
                .cornerRadius(8)
                .padding(.horizontal, 40)
        }
        
    }
       
}

struct ButtonRegister: View {
    let title: String
    let background: Color
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .font(.headline)
                .foregroundColor(Color.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(background)
                .cornerRadius(8)
                .padding(.horizontal, 40)
        }
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonLogin(title: "Value", background: ColorPalette.buttonBackground) {
//            login
        } // Provide an action closure for the preview
    }
}
