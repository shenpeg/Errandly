import SwiftUI
import GoogleSignIn

struct UserProfileView: View {
  @EnvironmentObject var authViewModel: AuthenticationViewModel
  
  var user: User
  
  var body: some View {
    return VStack(alignment: .leading, spacing: 0) {
      UserProfileInfoView(user: user)
        .environmentObject(authViewModel)
      
      UserProfileErrandsView(user: user)
    }
  }
}



