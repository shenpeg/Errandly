//
//  ContentView.swift
//  67443-sprint3
//

import SwiftUI

import GoogleSignIn

// custom colors
let darkBlue = Color(red: 0.09, green: 0.34, blue: 0.95)
let mint = Color(red: 0.84, green: 0.99, blue: 0.96)
let darkGray = Color(red: 0.25, green: 0.25, blue: 0.25)
let lightGray = Color(red: 0.93, green: 0.93, blue: 0.95)

struct ContentView: View {
  @EnvironmentObject var authViewModel: AuthenticationViewModel
  @ObservedObject var usersViewModel: UsersViewModel = UsersViewModel()

  var body: some View {
    let curUser = usersViewModel.getUserByUid(uid: GIDSignIn.sharedInstance.currentUser?.userID)

    return TabView {
      MarketplaceView()
        .tabItem {
          Image(systemName: "books.vertical")
          Text("Marketplace")
        }
      
      PostErrandView()
        .tabItem {
          Image(systemName: "rectangle.stack.badge.plus")
          Text("Post Errand")
        }
      
      UserProfileView(user: curUser, isCurUser: true)
        .environmentObject(authViewModel)
        .tabItem {
          Image(systemName: "person")
          Text("Profile")
        }
    }
  }
}
