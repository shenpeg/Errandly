//
//  MarketplaceViewModel.swift
//  67443-sprint3
//
//  Created by Ohnyoo Esther Bae on 10/31/23.
//

import SwiftUI

// from Swift Repos Lab
class MarketplaceViewModel: ObservableObject {
  @Published var errands: [Errand] = []
  @Published var searchText: String = ""
  @Published var filteredErrands: [Errand] = []
  
  func search(searchText: String) {
    self.filteredErrands = self.errands.filter { errand in
      return errand.name.lowercased().contains(searchText.lowercased())
    }
  }
}
