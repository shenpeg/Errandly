//
//  LocationPermissionView.swift
//  67443-sprint3
//
//  Created by Julia Graham on 10/22/23.
//

import SwiftUI

struct LocationPermissionView: View {
  @StateObject private var locationPermission:LocationViewModel=LocationViewModel()

  var body: some View {
    VStack {
      switch locationPermission.authorizationStatus{
        case .notDetermined:
          Text("not determied")
        case .restricted:
          Text("restricted")
        case .denied:
          Text("denied")
        case .authorizedAlways:
          VStack {
            Text(locationPermission.cordinates?.latitude.description ?? "N/A")
            Text(locationPermission.cordinates?.longitude.description ?? "N/A")
          }
        case .authorizedWhenInUse:
          VStack {
            Text(locationPermission.cordinates?.latitude.description ?? "N/A")
            Text(locationPermission.cordinates?.longitude.description ?? "N/A")
          }
        default:
          Text("no")
      }
      Button {
        switch locationPermission.authorizationStatus {
          case .notDetermined:
            locationPermission.requestLocationPermission()
          default:
            // note: in XCode 15 on an iPhone 15 Pro (simulator), opening settings with cause it to crash
            // Create the URL that deep links to your app's custom settings.
            if let url = URL(string: UIApplication.openSettingsURLString) {
                // Ask the system to open that URL.
                UIApplication.shared.open(url)
            }
        }
      } label: {
        Text("Ask Location Permission")
          .padding()
      }
    }
    .buttonStyle(.bordered)
  }
}
