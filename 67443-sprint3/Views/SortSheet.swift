//
//  SortSheet.swift
//  67443-sprint3
//
//  Created by Ohnyoo Esther Bae on 11/9/23.
//

import Foundation
import SwiftUI
import UIKit

struct SortSheet: View {
  @State var filteredErrands: [ErrandViewModel]
  @Environment(\.dismiss) var dismiss
  @ObservedObject var marketplaceViewModel = MarketplaceViewModel()
  var user: User

    var body: some View {
      let errandsVM = marketplaceViewModel.errandViewModels

      VStack {
        Text("Sort Errands By:")
          .font(.title2)
          .padding()
        Divider()
        Button {
          filteredErrands = filteredErrands.sorted(by: {$0.errand.datePosted > $1.errand.datePosted} )
        } label: {
          Text("Recent")
        }.padding()
        Button {
          filteredErrands = filteredErrands.sorted(by: {$0.errand.dateDue < $1.errand.dateDue} )
        } label: {
          Text("Due Date")
        }.padding()
        Button {
          filteredErrands = filteredErrands.sorted(by: {$0.errand.pay > $1.errand.pay} )
        } label: {
          Text("Compensation")
        }.padding()
      }
//      .presentationDetents([.height(300)])
      List {
        ForEach(filteredErrands) { errandVM in
          ErrandView(errand: errandVM.errand, isCurUser: false, user: user)
            .padding(.bottom, 10)
        }
      }
    }
}
