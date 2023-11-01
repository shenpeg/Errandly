//
//  ErrandListView.swift
//  67443-sprint3
//
//  Created by Julia Graham on 10/24/23.
//

import SwiftUI

struct MarketplaceView: View {
  @ObservedObject var errandRepository = ErrandRepository()
  @ObservedObject var marketplaceViewModel = MarketplaceViewModel()
  @State var searchField: String = ""
  @State var displayedErrands = [Errand]()
  
//  func loadData() {
//    Parser().fetchRepositories { (errands) in
//      self.marketplaceViewModel.errands = errands
//      self.displayedErrands = errands
//    }
//  }
    
  func displayErrands() {
    if searchField == "" {
        displayedErrands = marketplaceViewModel.errands
    } else {
      displayedErrands = marketplaceViewModel.filteredErrands
    }
  }

  var body: some View {
    let binding = Binding<String>(get: {
        self.searchField
      }, set: {
        self.searchField = $0
        self.marketplaceViewModel.search(searchText: self.searchField)
        self.displayErrands()
    })
    let errands = errandRepository.errands
    
    return NavigationView {
      VStack() {
        TextField("Search", text: binding).padding()
        List {
          ForEach(errands) { errand in
            ErrandView(errand: errand)
          }
        }.navigationBarTitle("Errands")
      } // .onAppear(perform: loadData)
      
    }
  }
}

struct MarketplaceView_Previews: PreviewProvider {
    static var previews: some View {
      MarketplaceView()
    }
}
