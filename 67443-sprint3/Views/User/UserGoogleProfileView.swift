//
//  UserProfileView.swift
//  67443-sprint3
//
//  Created by Julia Graham on 10/11/23.
//

import SwiftUI
import GoogleSignIn

struct UserGoogleProfileView: View {
  @EnvironmentObject var authViewModel: AuthenticationViewModel
  private var user: GIDGoogleUser? {
    return GIDSignIn.sharedInstance.currentUser
  }

  var body: some View {
    return Group {
      if let userProfile = user?.profile {
        VStack(spacing: 10) {
          HStack(alignment: .top) {
            UserProfileImageView(userProfile: userProfile)
              .padding(.leading)
            VStack(alignment: .leading) {
              Text(userProfile.name)
                .font(.headline)
              Text(userProfile.email)
            }
          }
          Spacer()
        }
        .toolbar {
          ToolbarItemGroup(placement: .navigationBarTrailing) {
            Button(NSLocalizedString("Disconnect", comment: "Disconnect button"), action: disconnect)
            Button(NSLocalizedString("Sign Out", comment: "Sign out button"), action: signOut)
          }
        }
      } else {
        Text(NSLocalizedString("Failed to get user profile!", comment: "Empty user profile text"))
      }
    }
  }

  func disconnect() {
    authViewModel.disconnect()
  }

  func signOut() {
    authViewModel.signOut()
  }
}

