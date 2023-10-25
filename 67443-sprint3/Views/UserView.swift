//
//  UserView.swift
//  67443-sprint3
//
//  Created by Julia Graham on 10/24/23.
//

import SwiftUI

struct UserView: View {
  @ObservedObject var userRepository = UserRepository()

  var body: some View {
    let user = userRepository.users.first
//    let users = userRepository.users
    print("here ---------------------------------------------")
        
    return VStack(alignment: .leading) {
      Text("User Information")
      Text("Name: \(user?.first_name ?? "n/a") \(user?.last_name ?? "n/a")")
      Text("Bio: \(user?.bio ?? "n/a")")
      Text("First picked up errand: \(user?.picked_up_errands.first?.name ?? "n/a") posted by \(user?.picked_up_errands.first?.owner.first_name ?? "n/a")")
      Text("First posted errand: \(user?.posted_errands.first?.name ?? "n/a") picked up by \(user?.posted_errands.first?.runner.first_name ?? "n/a")")
    }
  }
}
