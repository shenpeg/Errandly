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
            switch locationPermission.authorizationStatus {
              case .notDetermined:
                locationPermission.requestLocationPermission()
              default:
                // note: in XCode 15, opening settings on an iPhone 15 Pro (simulator) will cause a crash
                // Create the URL that deep links to your app's custom settings.
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    // Ask the system to open that URL.
                    UIApplication.shared.open(url)
                }
//                if let url = URL(string:UIApplication.openSettingsURLString) {
//                   if UIApplication.shared.canOpenURL(url) {
//                      UIApplication.shared.open(url, options: [:], completionHandler: nil)
//                   }
//                }
            }
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
