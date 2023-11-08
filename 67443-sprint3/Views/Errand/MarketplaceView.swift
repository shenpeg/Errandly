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

    var body: some View {
//      let errands = errandRepository.errands
      let errandsVM = marketplaceViewModel.errandViewModels
      
      return NavigationView {
        List {
          ForEach(errandsVM) { errandVM in
            ErrandView(errand: errandVM.errand, isCurUser: false)
              .padding(.bottom, 10)
          }
        }.navigationBarTitle("Errands")
          .listStyle(.plain)
      }
    }
}
