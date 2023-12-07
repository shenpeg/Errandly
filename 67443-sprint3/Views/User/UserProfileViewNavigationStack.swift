import SwiftUI
import GoogleSignIn

struct UserProfileViewNavigationStack: View {
  var user: User
  
  @EnvironmentObject var usersViewModel: UsersViewModel
  @EnvironmentObject var authViewModel: AuthenticationViewModel
  @EnvironmentObject var errandsViewModel: ErrandsViewModel
  @EnvironmentObject var tabUtil: TabUtil
  @Binding var marketplacePath: NavigationPath
  @Binding var profilePath: NavigationPath
    
  var body: some View {
     return NavigationStack(path: $profilePath) {
       UserProfileView(user: user)

      .navigationDestination(for: Errand.self) { errand in
        ErrandDetailsView(errand: errand, user: user, marketplacePath: $marketplacePath, profilePath: $profilePath)
      }
      .navigationDestination(for: ErrandOwner.self) { errandOwner in
        let errandOwnerUser = usersViewModel.getUser(userId: errandOwner.id)
        UserProfileView(user: errandOwnerUser!)
      }
      .navigationDestination(for: User.self) { user in
        EditUserProfileView(user: user)
         .environmentObject(authViewModel)
      }
//      .navigationDestination(for: String.self) { id in
//        let errand = errandsViewModel.getErrand(id)
//        EditErrandView(
//          user: user,
//          errand: errand,
//          profilePath: $profilePath
//        )
//      }
    }
    .accentColor(.black)
  }
}
