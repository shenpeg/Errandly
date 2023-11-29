//
//  LocationTimeFormatViewModel.swift
//  67443-sprint3
//
//  Created by /peggy on 11/8/23.
//

import Foundation
import SwiftUI
import CoreLocation

class TimeFormatViewModel: ObservableObject {
    func calculateTimeDifference(from date: Date) -> TimeInterval {
        let currentTime = Date()
        return currentTime.timeIntervalSince(date)
    }

    func formatTimeDifference(_ timeDifference: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth, .month, .year]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated

        if let formattedString = formatter.string(from: timeDifference) {
            return formattedString + " ago"
        } else {
            return "Posted time unknown"
        }
    }
}
