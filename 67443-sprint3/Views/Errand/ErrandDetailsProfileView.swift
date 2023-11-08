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
    @StateObject private var viewModel = LocationTimeFormatViewModel()


  var body: some View {
      let dateFormat = DateFormatter()
      dateFormat.dateFormat = "MM/dd/YY"
      let timeDifference = viewModel.calculateTimeDifference(from: errand.datePosted)

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
                  Text(viewModel.locationName)
                      .font(.footnote)
                      .foregroundColor(.secondary)
                  Text("|").font(.footnote).foregroundColor(.secondary)
                  Text(viewModel.formatTimeDifference(timeDifference))
                      .font(.footnote)
                      .foregroundColor(.secondary)
              }
          }
      }
      .onAppear {
        viewModel.getLocationName(for: CLLocation(latitude: errand.location.latitude, longitude: errand.location.longitude))
      }
  }

}
