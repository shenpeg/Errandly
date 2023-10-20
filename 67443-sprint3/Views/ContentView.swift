//
//  ContentView.swift
//  67443-sprint3
//

import SwiftUI

import GoogleSignIn

struct ContentView: View {
  @EnvironmentObject var authViewModel: AuthenticationViewModel
  
  @StateObject private var locationPermission:LocationViewModel=LocationViewModel()
  
  var body: some View {
    return Group {
      
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
<<<<<<< HEAD
            locationPermission.requestLocationPermission()
=======
            let _ = print("beginning btn")
            locationPermission.requestLocationPermission()
            let _ = print(locationPermission.authorizationStatus.rawValue)
            let _ = print("end btn")
>>>>>>> 1efb4f1b325a0edae86f98628a30ebbb62650450
          } label: {
            Text("Ask Location Permission")
              .padding()
          }
      }
      .buttonStyle(.bordered)
      
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
