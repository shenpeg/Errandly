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
  var user: User

    var body: some View {
      let errandsVM = marketplaceViewModel.errandViewModels
      
      return NavigationStack {
        List {
          ForEach(errandsVM) { errandVM in
            ErrandView(errand: errandVM.errand, isCurUser: false, user: user)
              .padding(.bottom, 10)
          }
        }
        .navigationBarTitle("Marketplace", displayMode: .inline)
        .listStyle(.plain)
      }
      .accentColor(.black)
    }
}
