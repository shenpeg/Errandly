//
//  ErrandDetailsViewModel.swift
//  67443-sprint3
//
//  Created by /peggy on 11/7/23.
//

import Foundation
import SwiftUI

class ErrandDetailsViewModel: ObservableObject {
    @Published var errand: Errand
    @Published var user: User
    private let errandRepository = ErrandRepository()
    private let userRepository = UserRepository()
    private let authenticationViewModel = AuthenticationViewModel()

    init(errand: Errand, user: User) {
        self.errand = errand
        self.user = user
    }
  
    func assignErrandToUser() {
        // Add the errand id to the user's picked_up_errands
        userRepository.addErrandToUser(userId: user.id!, errandId: errand.id!)
    }

    func addUserAsRunner() {
        let runner = ErrandRunner(id: user.id!, first_name: user.first_name, last_name: user.last_name)
        // Add user as runner of errand
        errandRepository.addRunnerToErrand(errandId: errand.id!, runner: runner)
    }
    
    func markAsCompleted() {
        errandRepository.updateErrandStatus(errandID: errand.id!, newStatus: "completed")
    }
  
    func markAsInProgress() {
        errandRepository.updateErrandStatus(errandID: errand.id!, newStatus: "in progress")
        assignErrandToUser()
        addUserAsRunner()
    }
  
}

