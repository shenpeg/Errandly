import SwiftUI

import GoogleSignIn

// custom colors
let darkBlue = Color(red: 0.09, green: 0.34, blue: 0.95)
let mint = Color(red: 0.84, green: 0.99, blue: 0.96)
let lightPurple = Color(red: 0.91, green: 0.60, blue: 0.98)
let darkGray = Color(red: 0.25, green: 0.25, blue: 0.25)
let lightGray = Color(red: 0.93, green: 0.93, blue: 0.95)

struct ContentView: View {
  @EnvironmentObject var authViewModel: AuthenticationViewModel
  // note: put all stuff in usersViewModel/MarketplaceViewModel!!!!!
  // - rename marketplaceviewmodel to errandsviewmodel?
  // just for now using userRepository/errandRepository
  @StateObject var userRepository: UserRepository = UserRepository()
  @StateObject var errandRepository: ErrandRepository = ErrandRepository()
  
  init() {
    UITabBar.appearance().backgroundColor = .white
    UITabBar.appearance().barTintColor = .white
  }
  
  var body: some View {
    return TabView {
      if (userRepository.getCurUser() != nil) {
        let curUser = userRepository.getCurUser()

        MarketplaceView(user: curUser!)
          .tabItem {
            Image(systemName: "house")
            Text("Marketplace")
          }
        
        PostErrandView(user: curUser!, isCurUser: true)
          .tabItem {
            Image(systemName: "plus.app")
            Text("Post Errand")
          }
        
        UserProfileView(user: curUser!, isCurUser: true)
          .environmentObject(authViewModel)
          .tabItem {
            Image(systemName: "person")
            Text("Profile")
          }
      }
    }
    .environmentObject(userRepository)
    .environmentObject(errandRepository)
  }
}
