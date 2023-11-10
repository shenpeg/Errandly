import Foundation
import Combine

// from Swift Repos Lab
class UsersViewModel: ObservableObject {
  @Published var userViewModels: [UserViewModel] = []
  private var cancellables: Set<AnyCancellable> = []
  
  @Published var userRepository = UserRepository()
  
  init() {
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
  
  func createNewUser(_ uid: String?, _ first_name: String?, _ last_name: String?, _ imageUrl: String?) {
    userRepository.createNewUser(uid, first_name, last_name, imageUrl)
  }
  
  func editUser(user: User, updatedUser: User) {
    userRepository.updateUser(user: user, updatedUser: updatedUser)
  }
  
}
