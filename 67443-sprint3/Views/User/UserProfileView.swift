import SwiftUI
import GoogleSignIn

struct UserProfileView: View {
  @EnvironmentObject var authViewModel: AuthenticationViewModel
  var user: User?
  var isCurUser: Bool

  var body: some View {
    return NavigationView {
      VStack(alignment: .leading, spacing: 0) {
        if (user != nil) {
          UserProfileInfoView(user: user!, isCurUser: isCurUser)
            .environmentObject(authViewModel)
          
          UserProfileErrandsView(user: user!, isCurUser: isCurUser)
        }
      }
    }
  }
}
