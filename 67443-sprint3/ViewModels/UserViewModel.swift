import Foundation
import Combine

class UserViewModel: ObservableObject, Identifiable {

  private let userRepository = UserRepository()
  @Published var user: User
  private var cancellables: Set<AnyCancellable> = []
  var id = ""

  init(user: User) {
    print("user view model init")
    print(user.first_name)
    self.user = user
    $user
      .compactMap { $0.id }
      .assign(to: \.id, on: self)
      .store(in: &cancellables)
  }
  
}
