//
//  UserProfileImageView.swift
//  67443-sprint3
//
//  Created by Julia Graham on 10/11/23.
//

import GoogleSignIn
import SwiftUI

struct UserProfileImageView: View {
  @ObservedObject var userProfileImageLoader: UserProfileImageLoader

  init(userProfile: GIDProfileData) {
    self.userProfileImageLoader = UserProfileImageLoader(userProfile: userProfile)
  }

  var body: some View {
    Image(uiImage: userProfileImageLoader.image)
      .resizable()
      .aspectRatio(contentMode: .fill)
      .frame(width: 45, height: 45, alignment: .center)
      .scaledToFit()
      .clipShape(Circle())
      .accessibilityLabel(Text("User profile image."))
  }
}

