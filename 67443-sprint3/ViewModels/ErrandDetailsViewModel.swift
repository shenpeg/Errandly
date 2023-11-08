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

    init(errand: Errand) {
        self.errand = errand
    }

    func markAsCompleted() {
        errand.status = "completed"
        // update in firestore?
    }
  
    func markAsInProgress() {
      errand.status = "in progress"
      // update in firestore?
    }
}

