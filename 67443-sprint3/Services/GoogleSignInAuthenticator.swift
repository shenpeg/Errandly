import Foundation
import FirebaseAuth
import FirebaseCore
import GoogleSignIn

/// An observable class for authenticating via Google.
final class GoogleSignInAuthenticator: ObservableObject {
  private var authViewModel: AuthenticationViewModel
  var usersViewModel: UsersViewModel = UsersViewModel()

  /// Creates an instance of this authenticator.
  /// - parameter authViewModel: The view model this authenticator will set logged in status on.
  init(authViewModel: AuthenticationViewModel) {
    self.authViewModel = authViewModel
  }

  /// Signs in the user based upon the selected account.'
  /// - note: Successful calls to this will set the `authViewModel`'s `state` property.
  func signIn() {
    let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
    let window = windowScene?.windows.first
    guard let rootViewController = window?.rootViewController else {
      print("There is no root view controller!")
      return
    }
    
    guard let clientID = FirebaseApp.app()?.options.clientID else { return }
    
    let config = GIDConfiguration(clientID: clientID)
    GIDSignIn.sharedInstance.configuration = config

    GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { signInResult, error in
      guard let signInResult = signInResult else {
        print("Error! \(String(describing: error))")
        return
      }
      
      guard let idToken = signInResult.user.idToken?.tokenString else {
        print("Error! with getting the idToken")
        return
      }
      
      let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: signInResult.user.accessToken.tokenString)
      
      Auth.auth().signIn(with: credential) { result, error in
        guard let googleUser = GIDSignIn.sharedInstance.currentUser else {
          print("Error! \(String(describing: error))")
          return
        }
        
        if let profile = googleUser.profile {
          if (self.usersViewModel.getUserByUid(uid: googleUser.userID) == nil) {
            self.usersViewModel.createNewUser(googleUser.userID, profile.givenName, profile.familyName, profile.imageURL(withDimension: 45)?.absoluteString)
          }
        }
        
        self.authViewModel.state = .signedIn(signInResult.user)
      }
        
    }
  }

  /// Signs out the current user.
  func signOut() {
    GIDSignIn.sharedInstance.signOut()
    authViewModel.state = .signedOutBtn
  }

  /// Disconnects the previously granted scope and signs the user out.
  func disconnect() {
    GIDSignIn.sharedInstance.disconnect { error in
      if let error = error {
        print("Encountered error disconnecting scope: \(error).")
      }
      self.signOut()
    }
  }

}
