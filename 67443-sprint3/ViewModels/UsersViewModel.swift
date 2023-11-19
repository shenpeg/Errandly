import Combine
import GoogleSignIn

import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore

class UsersViewModel: ObservableObject {
  // Set up properties here
  private let path: String = "users"
  private let store = Firestore.firestore()
  
  @Published var users: [User] = []
  private var cancellables: Set<AnyCancellable> = []
  
  var curUserUid: String = GIDSignIn.sharedInstance.currentUser?.userID ?? "n/a"

  
  init() {
    self.get()
  }
  
  func get() {
    store.collection(path)
      .addSnapshotListener{querySnapshot, error in
        if let error = error {
          print("Error getting users: \(error.localizedDescription)")
          return
        }
        
        self.users = querySnapshot?.documents.compactMap { document in
          try? document.data(as: User.self)
        } ?? []
      }
  }
  
  func getUser(userId: String) -> User? {
    if (curUserUid == "n/a") {
      return nil
    }
    else if let user = users.first(where: {$0.id == userId}) {
      return user
    }
    else {
      return nil
    }
  }
  
  func getCurUser() -> User? {
    if (curUserUid == "n/a") {
      return nil
    }
    else if let user = users.first(where: {$0.uid == curUserUid}) {
      return user
    }
    else {
      return nil
    }
  }
  
  // necessary for GoogleSignInAuthenticator, as there is no current user at that point
  func getUserByUid(uid: String?) -> User? {
      if (uid == nil) {
        return nil
      }
      else if let user = users.first(where: {$0.uid == uid}) {
        return user
      }
      else {
        return nil
      }
    }
  
  func deletePostedErrand(owner: User, errand: Errand) {
    guard let userId = owner.id else { return }
    guard let errandId = errand.id else { return }
    
    store.collection(path).document(userId).updateData([
      "posted_errands": FieldValue.arrayRemove([errandId])
    ])
  }
  
  func deletePickedUpErrand(runner: User, errand: Errand) {
    guard let userId = runner.id else { return }
    guard let errandId = errand.id else { return }
    
    store.collection(path).document(userId).updateData([
      "picked_up_errands": FieldValue.arrayRemove([errandId])
    ])
  }
  
  
  func createNewUser(_ uid: String?, _ first_name: String?, _ last_name: String?, _ imageUrl: String?) {
    do {
      guard let uid = uid else { return }

      let newUser = User(uid: uid, bio: "", can_help_with: [], first_name: first_name ?? "", last_name: last_name ?? "", pfp: imageUrl ?? "", phone_number: 0000000000, picked_up_errands: [], posted_errands: [], school_year: "")
      _ = try store.collection(path).addDocument(from: newUser)
    }
    catch {
      fatalError("Unable to add book: \(error.localizedDescription).")
    }
  }
  
  func updateUser(user: User, updatedUser: User) {
    guard let userId = user.id else { return }
    do {
      try store.collection(path).document(userId).setData(from: updatedUser)
    }
    catch {
      fatalError("Unable to update user: \(error.localizedDescription).")
    }
  }
  
  func addErrandToUser(userId: String, errandId: String, type: String) {
    let userRef = store.collection(path).document(userId)
      userRef.updateData([type: FieldValue.arrayUnion([errandId])]) { error in
          if let error = error {
              print("Unable to add errand to user: \(error.localizedDescription)")
          }
      }
  }
  
}
