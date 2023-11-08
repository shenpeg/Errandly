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
    private let errandRepository = ErrandRepository()
    private let userRepository = UserRepository()
    private let authenticationViewModel = AuthenticationViewModel()

    init(errand: Errand) {
        self.errand = errand
    }
    
    func markAsCompleted() {
        errandRepository.updateErrandStatus(errandID: errand.id!, newStatus: "completed")
    }
  
    func markAsInProgress() {
        errandRepository.updateErrandStatus(errandID: errand.id!, newStatus: "in progress")
        
        //userRepository.addPickedUpErrand(user, errand)
    }
}

