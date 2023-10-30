//
//  ContentView.swift
//  67443-sprint3
//

import SwiftUI

import GoogleSignIn

struct ContentView: View {
  @EnvironmentObject var authViewModel: AuthenticationViewModel
  
  var body: some View {
    TabView {
      MarketplaceView()
        .tabItem {
          Image(systemName: "books.vertical")
          Text("Marketplace")
        }
      
      NewErrandView()
        .tabItem {
          Image(systemName: "rectangle.stack.badge.plus")
          Text("New Errand")
        }
      
      UserView()
        .tabItem {
          Image(systemName: "chart.bar.xaxis")
          Text("Profile")
        }
    }
  }
}
