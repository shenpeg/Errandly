//
//  ErrandDetailsProfileView.swift
//  67443-sprint3
//
//  Created by /peggy on 11/1/23.
//
// This view is for displaying the author of an errand post

import SwiftUI
import CoreLocation

struct ErrandDetailsProfileView: View {
    var errand: Errand
    @State private var locationName: String = ""

  var body: some View {
      let dateFormat = DateFormatter()
      dateFormat.dateFormat = "MM/dd/YY"
      let timeDifference = calculateTimeDifference(from: errand.datePosted)

      return HStack {
          AsyncImage(url: URL(string: "https://via.placeholder.com/34x34")) { phase in
              switch phase {
              case .success(let image):
                  image
                      .resizable()
                      .aspectRatio(contentMode: .fill)
                      .frame(width: 34, height: 34)
                      .clipShape(Circle())
              case .empty:
                  EmptyView()
              case .failure:
                  Image(systemName: "xmark.octagon")
              @unknown default:
                  EmptyView()
              }
          }
          
          VStack(alignment: .leading) {
              Text("\(errand.owner.first_name) \(errand.owner.last_name)")
                  .font(.headline)
                  .foregroundColor(.primary)
              HStack {
                  Text(locationName)
                      .font(.footnote)
                      .foregroundColor(.secondary)
                  Text("|").font(.footnote).foregroundColor(.secondary)
                  Text(formatTimeDifference(timeDifference))
                      .font(.footnote)
                      .foregroundColor(.secondary)
              }
          }
      }
      .onAppear {
          getLocationName(for: CLLocation(latitude: errand.location.latitude, longitude: errand.location.longitude))
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
    
    // Fetch location name using reverse geocoding
    func getLocationName(for location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print("Error in reverse geocoding: \(error.localizedDescription)")
            } else if let placemark = placemarks?.first {
                // Display state name with placemark.administrativeArea
                self.locationName = placemark.administrativeArea ?? "Unknown State"
            }
        }
    }
}
