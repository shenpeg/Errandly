import Combine

import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore

class ErrandsViewModel: ObservableObject {
  // Set up properties here
  private let path: String = "errands"
  private let store = Firestore.firestore()
  
  @Published var errands: [Errand] = []
  @Published var filteredErrands: [Errand] = []
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
        
        self.filteredErrands = self.errands
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
  
  func getErrand(_ id: String) -> Errand {
    if let errand = errands.first(where: {$0.id == id}) {
      return errand
    }
    else {
      fatalError("Unable to find the corresponding errand.")
    }
  }

  func getErrandsByStatus(_ ids: [String]) -> [String: [Errand]] {
    var errandsByStatus: [String: [Errand]] = ["new": [], "in progress": [], "completed": []]
    ids.forEach {id in
      if let errand = errands.first(where: {$0.id == id}) {
        errandsByStatus[errand.status]!.append(errand)
      }
    }
    return errandsByStatus
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
  
  func addUserAsRunner(user: User, errand: Errand) {
    let runner = ErrandRunner(id: user.id!, first_name: user.first_name, last_name: user.last_name)
    // Add user as runner of errand
    self.addRunnerToErrand(errandId: errand.id!, runner: runner)
  }
  
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
  
  func filterErrands(searchText: String, selectedTags: String) {
    self.filteredErrands = self.errands.filter { errand in return
      if (!searchText.isEmpty && selectedTags != "") {
        errand.name.lowercased().contains(searchText.lowercased()) &&
        errand.tags.contains(selectedTags)
      }
      else if (!searchText.isEmpty) {
        errand.name.lowercased().contains(searchText.lowercased())
      }
      else if (selectedTags != "") {
        errand.tags.contains(selectedTags)
      }
      else {
        true
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
