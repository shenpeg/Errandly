//
//  _7443_sprint3App.swift
//  67443-sprint3
//
// Using GoogleSignIn sample DaysUntilBirthday code
//

import SwiftUI

import GoogleSignIn

import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct _7443_sprint3App: App {
  @StateObject var authViewModel = AuthenticationViewModel()
  
  // register app delegate for Firebase setup
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

  var body: some Scene {
    WindowGroup {
      WelcomeView()
        .environmentObject(authViewModel)
        .onAppear {
          GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if let user = user {
              self.authViewModel.state = .signedIn(user)
            } else if let error = error {
              self.authViewModel.state = .signedOut
              print("There was an error restoring the previous sign-in: \(error)")
            } else {
              self.authViewModel.state = .signedOut
            }
          }
        }
        .onOpenURL { url in
          GIDSignIn.sharedInstance.handle(url)
        }
    }
  }
}
