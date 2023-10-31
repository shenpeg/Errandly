//
//  ErrandListView.swift
//  67443-sprint3
//
//  Created by Julia Graham on 10/24/23.
//

import SwiftUI

struct MarketplaceView: View {
  @ObservedObject var errandRepository = ErrandRepository()
  var searchField: String = ""
  var displayedErrands = [Errand]()

    var body: some View {
      let errands = errandRepository.errands
      
      return NavigationView {
        List {
          ForEach(errands) { errand in
            ErrandView(errand: errand)
          }
        }.navigationBarTitle("Errands")
      }
    }
}

struct MarketplaceView_Previews: PreviewProvider {
    static var previews: some View {
      MarketplaceView()
    }
}
