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
  @EnvironmentObject var errandsViewModel: ErrandsViewModel
  @Environment(\.dismiss) var dismiss
  
  @Binding var searchField: String
  @Binding var selectedTags: String // : [String] = []

    var body: some View {
      let errands = errandsViewModel.errands
      
      VStack {
        Text("Sort Errands By:")
          .font(.title2)
          .padding()
        Divider()
        Button {
          errandsViewModel.errands = errands.sorted(by: {$0.datePosted > $1.datePosted} )
          errandsViewModel.filterErrands(searchText: self.searchField, selectedTags: self.selectedTags)
        } label: {
          Text("Recent")
        }.padding()
        Button {
          errandsViewModel.errands = errands.sorted(by: {$0.dateDue < $1.dateDue} )
          errandsViewModel.filterErrands(searchText: self.searchField, selectedTags: self.selectedTags)
        } label: {
          Text("Due Date")
        }.padding()
        Button {
          errandsViewModel.errands = errands.sorted(by: {$0.pay > $1.pay} )
          errandsViewModel.filterErrands(searchText: self.searchField, selectedTags: self.selectedTags)
        } label: {
          Text("Compensation")
        }.padding()
      }
      .presentationDetents([.height(300)])
    }
}
