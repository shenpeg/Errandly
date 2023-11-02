//
//  ErrandListView.swift
//  67443-sprint3
//
//  Created by Julia Graham on 10/24/23.
//

import SwiftUI

struct MarketplaceView: View {
  @ObservedObject var errandRepository = ErrandRepository()

    var body: some View {
      let errands = errandRepository.errands
      
      return NavigationView {
        List {
          ForEach(errands) { errand in
            ErrandView(errand: errand, isCurUser: false)
              .padding(.bottom, 10)
          }
        }.navigationBarTitle("Errands")
          .listStyle(.plain)
      }
    }
}
