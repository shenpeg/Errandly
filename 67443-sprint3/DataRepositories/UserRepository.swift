//
//  ErrandRepository.swift
//  67443-sprint3
//
//  Created by Julia Graham on 10/24/23.
//

import Combine

import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore

class UserRepository: ObservableObject {
  // Set up properties here
  private let path: String = "users"
  private let store = Firestore.firestore()
  
  @Published var users: [User] = []
  private var cancellables: Set<AnyCancellable> = []
  
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
  
  func addErrandToUser(userId: String, errandId: String) {
      let userRef = store.collection(path).document(userId)
      userRef.updateData(["picked_up_errands": FieldValue.arrayUnion([errandId])]) { error in
          if let error = error {
              print("Unable to add errand to user: \(error.localizedDescription)")
          }
      }
  }
  
}
