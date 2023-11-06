import SwiftUI

struct UserProfileView: View {
  @ObservedObject var userRepository = UserRepository()
  var userId: String
  var isCurUser: Bool

  var body: some View {
    // temporary, will be changed to get the current user
    let user = userRepository.users.first!
    
    return VStack(alignment: .leading, spacing: 0) {
      UserProfileInfoView(user: user, isCurUser: isCurUser)
      
      UserProfileErrandsView(user: user, isCurUser: isCurUser)
    }
  }
}
