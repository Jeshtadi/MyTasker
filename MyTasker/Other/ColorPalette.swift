//
//  ColorPalette.swift
//  MyTasker
//
//  Created by Anushya Jeshtadi on 23/01/2025.


//using

import SwiftUI

struct ColorPalette {
    // Colors adapted for accessibility with sufficient contrast
    static let primaryBackground = Color(dynamicLight: "#F4F1FA", dark: "#1E1230") // Light mode: soft off-white, Dark mode: deep indigo
    static let secondaryBackground = Color(dynamicLight: "#FFFFFF", dark: "#2A1D40") // Light mode: pure white, Dark mode: muted dark purple
    static let accentColor = Color(dynamicLight: "#009688", dark: "#4DB6AC") // Light mode: teal, Dark mode: lighter teal for visibility
    static let textPrimary = Color(dynamicLight: "#3D3D3D", dark: "#EDEDED") // Light mode: near-black, Dark mode: near-white
    static let buttonBackground = Color(dynamicLight: "#D81B60", dark: "#F06292") // Light mode: strong pink, Dark mode: soft pink

    static let cardBackground = Color(dynamicLight: "#FFFFFF", dark: "#24183D") // Light mode: white, Dark mode: dark purple
    static let borderColor = Color(dynamicLight: "#BDBDBD", dark: "#5A4C71") // Light mode: neutral gray, Dark mode: soft muted purple
    static let highlightColor = Color(dynamicLight: "#E91E63", dark: "#F48FB1") // Light mode: vibrant pink, Dark mode: softer pink

    static let errorColor = Color(dynamicLight: "#D32F2F", dark: "#EF5350") // Light mode: deep red, Dark mode: accessible red
    static let successColor = Color(dynamicLight: "#388E3C", dark: "#66BB6A") // Light mode: deep green, Dark mode: softer green
    static let warningColor = Color(dynamicLight: "#FBC02D", dark: "#FFCA28") // Light mode: deep yellow, Dark mode: muted yellow
    static let disabledColor = Color(dynamicLight: "#9E9E9E", dark: "#757575") // Light mode: medium gray, Dark mode: darker gray
    static let shadowColor = Color(dynamicLight: "#888888", dark: "#222222") // Light mode: neutral gray shadow, Dark mode: deep shadow
    static let eventColor = Color(dynamicLight: "#7B1FA2", dark: "#BA68C8")// Light mode: deep purple, Dark mode: softer purple
    static let taskColor = Color(dynamicLight: "#1976D2", dark: "#90CAF9") // Light mode: blue, Dark mode: light blue
}

 
extension Color {
    init(dynamicLight lightHex: String, dark darkHex: String) {
        self.init(UIColor { traitCollection in
            let hex = traitCollection.userInterfaceStyle == .dark ? darkHex : lightHex
            return UIColor(hex: hex)
        })
    }
}

 
extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.currentIndex = hex.hasPrefix("#") ? hex.index(after: hex.startIndex) : hex.startIndex
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        let red = CGFloat((rgb >> 16) & 0xFF) / 255.0
        let green = CGFloat((rgb >> 8) & 0xFF) / 255.0
        let blue = CGFloat(rgb & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
