//
//  ContentView.swift
//  67443-sprint3
//

import SwiftUI

import GoogleSignIn

import MapKit
import CoreLocation

struct ContentView: View {
  @EnvironmentObject var authViewModel: AuthenticationViewModel
  
  var body: some View {
    return Group {
      
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
