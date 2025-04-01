//
//  MoodleEvent.swift
//  MyTasker
//
//  Created by Anushya Jeshtadi on 02/03/2025.
//


//import Foundation
//
//struct MoodleEvent: Codable, Identifiable {
//    var id: String
//    var title: String
//    var startDate: TimeInterval
//    var endDate: TimeInterval
//    var description: String
//    var notifyBefore: TimeInterval?  // Optional alert before the event
//}


//import Foundation
//import SwiftUI
//
//// Create a custom struct that can hold attributed strings
//struct MoodleEvent: Codable, Identifiable {
//    var id: String
//    var title: String
//    var startDate: TimeInterval
//    var endDate: TimeInterval
//    var description: String // Store raw description
//    var notifyBefore: TimeInterval?  // Optional alert before the event
//    
//    // Use an NSAttributedString to parse the raw description
//    func attributedDescription() -> NSAttributedString {
//        let data = description.data(using: .utf8)!
//        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
//            .documentType: NSAttributedString.DocumentType.plain,
//            .characterEncoding: String.Encoding.utf8.rawValue
//        ]
//        
//        let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil)
//        return attributedString ?? NSAttributedString(string: description) // Fallback to plain text
//    }
//}



import Foundation
import SwiftUI

struct MoodleEvent: Codable, Identifiable {
    var id: String
    var title: String
    var startDate: TimeInterval
    var endDate: TimeInterval
    var description: String
    var notifyBefore: TimeInterval?
    var color: String = "#FFA500"
    
}
