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
  
  
  //SORT METHODS
//  func sortByDate() -> [Errand] {
//    return self.errands.sorted(by: ErrandDate)
//  }
  

}

