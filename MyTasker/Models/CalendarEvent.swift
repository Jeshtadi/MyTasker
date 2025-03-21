//
//  CalanderEvent.swift
//  MyTasker
//
//  Created by Anushya Jeshtadi on 23/02/2025.
//
import Foundation

struct CalendarEvent: Codable, Identifiable {
    var id: String
    var title: String
    var startDate: TimeInterval
    var endDate: TimeInterval
    var description: String
}
