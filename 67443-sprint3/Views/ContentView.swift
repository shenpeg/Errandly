//
//  ContentView.swift
//  67443-sprint3
//

import SwiftUI

import GoogleSignIn
import CoreLocation

struct ContentView: View {
  @EnvironmentObject var authViewModel: AuthenticationViewModel
  @StateObject var locationPermission:LocationViewModel=LocationViewModel()
  
  var body: some View {
    return Group {
      LocationPermissionView(locationPermission: locationPermission)
      
      VStack {
        Text("Distance from current location to CMU in meters: 40.4432° N (lat), 79.9428° W (long)")
        switch locationPermission.authorizationStatus {
          case .authorizedAlways, .authorizedWhenInUse:
          Text(String(CLLocation(latitude: locationPermission.cordinates?.latitude ?? 0.0, longitude: locationPermission.cordinates?.longitude ?? 0.0).distance(from: CLLocation(latitude: 40.4432, longitude: -79.9428))))
          default:
            Text("No current location")
        }
      }
      
      LocationSearchView(locationSearchService: LocationSearchService())

      NavigationView {
        switch authViewModel.state {
        case .signedIn:
          UserProfileView()
            .navigationTitle(
              NSLocalizedString(
                "User Profile",
                comment: "User profile navigation title"
              ))
        case .signedOut:
          SignInView()
            .navigationTitle(
              NSLocalizedString(
                "Sign-in with Google",
                comment: "Sign-in navigation title"
              ))
        }
      }
      .navigationViewStyle(StackNavigationViewStyle())
    }
  }
}
