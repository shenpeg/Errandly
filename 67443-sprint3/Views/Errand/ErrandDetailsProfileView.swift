//
//  ErrandDetailsProfileView.swift
//  67443-sprint3
//
//  Created by /peggy on 11/1/23.
//

import SwiftUI

struct ErrandDetailsInfoView: View {
    var errand: Errand

    var body: some View {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MM/dd/YY"
        let timeDifference = calculateTimeDifference(from: errand.date_posted)

        return VStack {
            HStack {
                Text("Owner:")
                Text("\(errand.owner.first_name) \(errand.owner.last_name)")
                    .font(.headline)
                    .foregroundColor(.primary)
            }

            HStack {
                Text("Location:")
                Text("\(errand.location.latitude), \(errand.location.longitude)")
            }

            HStack {
                Text("Date Posted:")
                Text(formatTimeDifference(timeDifference))
            }
        }
    }

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
            return "Unknown"
        }
    }
}
