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

class ErrandRepository: ObservableObject {
  // Set up properties here
  private let path: String = "errands"
  private let store = Firestore.firestore()
  
  @Published var errands: [Errand] = []
  private var cancellables: Set<AnyCancellable> = []
  
  init() {
    self.get()
  }
  
  func get() {
    store.collection(path)
      .addSnapshotListener{querySnapshot, error in
        if let error = error {
          print("Error getting errands: \(error.localizedDescription)")
          return
        }
        
        self.errands = querySnapshot?.documents.compactMap { document in
          try? document.data(as: Errand.self)
        } ?? []
      }
  }
  
  //CRUD Methods
  func create(_ errand: Errand){
    do {
      _ = try store.collection(path).addDocument(from: errand)
    } catch {
      fatalError("Unable to add book: \(error.localizedDescription).")
    }
  }
  
//  func update(_ errand: Errand) {
//    guard let errandId = errand.id else {return}
//
//    do {
//      try store.collection(path).document(errand.id).setData(from: errand)
//    } catch {
//      fatalError("Unable to update book: \(error.localizedDescription)")
//    }
//  }
  
  func delete(_ errand: Errand) {
    guard let errandId = errand.id else { return }
    
    store.collection(path).document(errandId).delete { error in
      if let error = error {
        fatalError("Unable to delete errand: \(error.localizedDescription).")
      }
    }
  }

  //SORT METHODS
//  func sortByDate() -> [Errand] {
//    return self.errands.sorted(by: ErrandDate)
//  }
  
  
  // after picking up errand
  func addRunnerToErrand(errandId: String, runner: ErrandRunner) {
      let errandRef = store.collection(path).document(errandId)
      let runnerData: [String: Any] = [
          "errandId": runner.errandId ?? "",
          "id": runner.id,
          "first_name": runner.first_name,
          "last_name": runner.last_name
      ]
      errandRef.updateData(["runner": runnerData]) { error in
          if let error = error {
              print("Error adding runner to errand: \(error.localizedDescription)")
          }
      }
  }
  
  // for status updates in errand detail page:
  func updateErrandStatus(errandID: String, newStatus: String) {
      let errandRef = store.collection(path).document(errandID)
      errandRef.updateData(["status": newStatus]) { error in
          if let error = error {
              print("Error updating errand status: \(error.localizedDescription)")
          }
      }
  }
  
  // refactor?
  func updateUser(owner: ErrandOwner, runner: ErrandRunner) {
    errands.forEach { errand in
      if (errand.owner.id == owner.id) {
        let updatedErrand = Errand(dateDue: errand.dateDue, datePosted: errand.datePosted, description: errand.description, location: errand.location, name: errand.name, owner: owner, runner: errand.runner, pay: errand.pay, status: errand.status, tags: errand.tags)
        do {
          try store.collection(path).document(errand.id!).setData(from: updatedErrand)
        } catch {
          fatalError("Unable to update errand owner: \(error.localizedDescription).")
        }
      }
      else if (errand.runner != nil && errand.runner!.id == runner.id) {
        let updatedErrand = Errand(dateDue: errand.dateDue, datePosted: errand.datePosted, description: errand.description, location: errand.location, name: errand.name, owner: errand.owner, runner: runner, pay: errand.pay, status: errand.status, tags: errand.tags)
        do {
          try store.collection(path).document(errand.id!).setData(from: updatedErrand)
        } catch {
          fatalError("Unable to update errand runner: \(error.localizedDescription).")
        }
      }
    }
  }

}

