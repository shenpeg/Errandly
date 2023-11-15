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
  
  func create(_ errand: Errand) async -> Errand {
    do {
      return try await store.collection(path).addDocument(from: errand).getDocument().data(as: Errand.self)
    } catch {
      fatalError("Unable to add book: \(error.localizedDescription).")
    }
  }
  
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

  func updateUser(user: User, userId: String, postedErrandsIds: [String], pickedUpErrandsIds: [String]) {
    postedErrandsIds.forEach {id in
      let errandRef = store.collection(path).document(id)
      errandRef.setData(["owner": [
        "first_name": user.first_name,
        "id": userId,
        "last_name": user.last_name,
        "pfp": user.pfp,
        "phone_number": user.phone_number
      ]], merge: true) { error in
        if let error = error {
          print("Error updating errand owner: \(error.localizedDescription)")
        }
      }
    }
    pickedUpErrandsIds.forEach {id in
      let errandRef = store.collection(path).document(id)
      errandRef.setData(["runner": [
        "first_name": user.first_name,
        "id": userId,
        "last_name": user.last_name
      ]], merge: true) { error in
        if let error = error {
          print("Error updating errand runner: \(error.localizedDescription)")
        }
      }
    }
  }
}
