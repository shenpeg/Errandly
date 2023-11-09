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
  
  // note: these functions also need to update the other users involved
  
  func addPickedUpErrand(_ user: User, _ errand: Errand) {
//    guard let userId = user.id else { return }
//    guard let errandId = errand.id else { return }
//
//    let pickedUpErrandOwner = PickedUpErrandOwner(id: errand.owner.id, first_name: errand.owner.first_name, last_name: errand.owner.last_name)
//    //let pickedUpErrand = PickedUpErrand(id: errandId, dateDue: errand.dateDue, datePosted: errand.datePosted, name: errand.name, owner: pickedUpErrandOwner, pay: errand.pay, status: errand.status)
//
//    var pickedUpErrandEncoded: (Any)? = nil
//    do {
//      pickedUpErrandEncoded = try Firestore.Encoder().encode(pickedUpErrand)
//    }
//    catch {
//      print("error encoding picked up errand")
//    }
//
//    store.collection(path).document(userId).updateData([
//        "picked_up_errands": FieldValue.arrayUnion([pickedUpErrandEncoded!])
//      ])
  }
  
  func addPostedErrand(_ user: User, _ errand: Errand) {
//    guard let userId = user.id else { return }
//    guard let errandId = errand.id else { return }
//
//    let postedErrand = PostedErrand(id: errandId, dateDue: errand.dateDue, datePosted: errand.datePosted, name: errand.name, runner: nil, pay: errand.pay, status: errand.status)
//
//    var postedErrandEncoded: (Any)? = nil
//    do {
//      postedErrandEncoded = try Firestore.Encoder().encode(postedErrand)
//    }
//    catch {
//      print("error encoding posted errand")
//    }
//
//    store.collection(path).document(userId).updateData([
//      "posted_errands": FieldValue.arrayUnion([postedErrandEncoded!])
//      ])
  }
  
  func addErrandRunner(_ user: User, _ errand: Errand, _ runner: User) {
    // to implement!
  }
}
