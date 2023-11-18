import Foundation
import GoogleSignIn
import Combine

// from Swift Repos Lab
class UsersViewModel: ObservableObject {
  @Published var userViewModels: [UserViewModel] = []
  private var cancellables: Set<AnyCancellable> = []
  
  @Published var userRepository = UserRepository()
  var curUserUid: String = GIDSignIn.sharedInstance.currentUser?.userID ?? "n/a"
  
  init() {
    print("users view model init")
    userRepository.$users.map { users in
      return users.map(UserViewModel.init)
    }
    .assign(to: \.userViewModels, on: self)
    .store(in: &cancellables)
  }
  
  func destroyPostedErrand(owner: User, errand: Errand) {
    userRepository.deletePostedErrand(owner: owner, errand: errand)
  }
  
  func destroyPickedUpErrand(runner: User, errand: Errand) {
    userRepository.deletePickedUpErrand(runner: runner, errand: errand)
  }
  
  func getUser(_ id: String) -> User? {
    if let userVM = userViewModels.first(where: {$0.id == id}) {
      return userVM.user
    }
    else {
      return nil
      // fatalError("Unable to find the corresponding user.")
    }
  }
  
  func getUserByUid(uid: String?) -> User? {
    if (uid == nil) {
      return nil
    }
    else if let userVM = userViewModels.first(where: {$0.user.uid == uid}) {
      return userVM.user
    }
    else {
      return nil
    }
  }
  
  func getCurUser() -> User? {
    print("users view model get cur user")
    if (curUserUid == "n/a") {
      return nil
    }
    else if let userVM = userViewModels.first(where: {$0.user.uid == curUserUid}) {
      return userVM.user
    }
    else {
      return nil
    }
  }
  
  func createNewUser(_ uid: String?, _ first_name: String?, _ last_name: String?, _ imageUrl: String?) {
    userRepository.createNewUser(uid, first_name, last_name, imageUrl)
  }
  
  func editUser(user: User, updatedUser: User) {
    print("users view model edit user")
    userRepository.updateUser(user: user, updatedUser: updatedUser)
  }
  
  func addErrandToUser(userId: String, errandId: String, type: String) {
    userRepository.addErrandToUser(userId: userId, errandId: errandId, type: "posted_errands")
  }
  
}
