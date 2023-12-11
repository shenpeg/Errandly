import SwiftUI

import GoogleSignIn

// custom colors
let black = Color.black
let white = Color.white
let darkBlue = Color(red: 0.09, green: 0.34, blue: 0.95)
let mint = Color(red: 0.84, green: 0.99, blue: 0.96)
let darkerMint = Color(red: 0.506, green: 0.698, blue: 0.953)
let lightPurple = Color(red: 0.91, green: 0.60, blue: 0.98)
let darkGray = Color(red: 0.25, green: 0.25, blue: 0.25)
let lightGray = Color(red: 0.93, green: 0.93, blue: 0.95) //view tag background
let backgroundGray = Color(red: 0.945, green: 0.945, blue: 0.945)
let grayOutGray = Color(red: 0.83, green: 0.83, blue: 0.83) //completed errand cards background
//Color(red: 0.965, green: 0.961, blue: 0.937)
// Color(red: 0.949, green: 0.965, blue: 0.937)

// tags
let tags: [String] = [
  "📚 on-campus",
  "🏙️ off-campus",
  "🐰 pets",
  "🌱 plants",
  "🧃 food/drink",
  "🏠 house/dorm",
  "🧼 cleaning",
  "🫧 laundry",
  "🚗 car",
  "🚚 moving in/out",
  "📦 storage"]

struct ContentView: View {
  @EnvironmentObject var authViewModel: AuthenticationViewModel
  @StateObject var usersViewModel: UsersViewModel = UsersViewModel()
  @StateObject var errandsViewModel: ErrandsViewModel = ErrandsViewModel()
  @StateObject var tabUtil: TabUtil = TabUtil()
  @StateObject var locationViewModel: LocationViewModel = LocationViewModel()
  @State private var marketplacePath = NavigationPath()
  @State private var profilePath = NavigationPath()
  @State private var isOnboardingPresented = true

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
    .environmentObject(locationViewModel)
    .onAppear {
        if UserDefaults.standard.bool(forKey: "hasSeenTutorial") == false {
            isOnboardingPresented = true
            UserDefaults.standard.set(true, forKey: "hasSeenTutorial")
        }
    }
    .overlay(
        isOnboardingPresented ? TutorialView(isOnboardingPresented: $isOnboardingPresented)
                               .transition(.opacity) : nil
    )
    .accentColor(darkBlue)
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
