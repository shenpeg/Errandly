import SwiftUI

import GoogleSignIn

// custom colors
let darkBlue = Color(red: 0.09, green: 0.34, blue: 0.95)
let mint = Color(red: 0.84, green: 0.99, blue: 0.96)
let lightPurple = Color(red: 0.91, green: 0.60, blue: 0.98)
let darkGray = Color(red: 0.25, green: 0.25, blue: 0.25)
let lightGray = Color(red: 0.93, green: 0.93, blue: 0.95)

// tags
let tags: [String] = ["on-campus", "off-campus", "house/dorm", "food/drink", "cleaning", "animals", "plants", "car", "laundry", "moving in/out"]

struct ContentView: View {
  @EnvironmentObject var authViewModel: AuthenticationViewModel
  @StateObject var usersViewModel: UsersViewModel = UsersViewModel()
  @StateObject var errandsViewModel: ErrandsViewModel = ErrandsViewModel()
  @StateObject var tabUtil: TabUtil = TabUtil()
  @State private var marketplacePath = NavigationPath()
  @State private var profilePath = NavigationPath()

  init() {
    UITabBar.appearance().backgroundColor = .white
    UITabBar.appearance().barTintColor = .white
  }
  
  var body: some View {
    return TabView(selection: tabSelection()) {
      if (usersViewModel.getCurUser() != nil) {
        let curUser = usersViewModel.getCurUser()

        MarketplaceView(user: curUser!, marketplacePath: $marketplacePath, profilePath: $profilePath)
          .tabItem {
            Image(systemName: "house").padding(.bottom, 10)
            Text("Marketplace")
          }
          .tag(1)
        
        PostErrandView(user: curUser!, profilePath: $profilePath)
          .tabItem {
            Image(systemName: "plus.app").padding(.bottom, 10)
            Text("Post Errand")
          }
          .tag(2)
        
        UserProfileViewNavigationStack(user: curUser!, marketplacePath: $marketplacePath, profilePath: $profilePath)
          .environmentObject(authViewModel)
          .tabItem {
            Image(systemName: "person").padding(.bottom, 10)
            Text("Profile")
          }
          .tag(3)
      }
    }
    .environmentObject(usersViewModel)
    .environmentObject(errandsViewModel)
    .environmentObject(tabUtil)
  }
  
  private func tabSelection() -> Binding<Int> {
    Binding {
      tabUtil.tabSelection
    }
    set: { tappedTab in
      if tappedTab == tabUtil.tabSelection {
        if (tappedTab == 1) {
          marketplacePath = NavigationPath()
        }
        else if (tappedTab == 3) {
          profilePath = NavigationPath()
        }
      }
      tabUtil.tabSelection = tappedTab
    }
  }
}
