//
//  ErrandListView.swift
//  67443-sprint3
//
//  Created by Julia Graham on 10/24/23.
//

import SwiftUI

let tags: [String] = ["on-campus", "off-campus", "house/dorm", "food/drink", "cleaning", "animals", "plants", "car", "laundry", "moving in/out"]

struct MarketplaceView: View {
  @EnvironmentObject var errandRepository: ErrandRepository
  @State private var searchField = ""
  @State private var selectedTags = "" // : [String] = []
  @State private var tagIsClicked: Bool = false
  
  @State private var showingSheet = false
  var user: User
  
  var body: some View {
    let _ = print("marketplace view??")
//    let errandsVM = marketplaceViewModel.errandViewModels
    let errands = errandRepository.errands
    // code reference: https://www.youtube.com/watch?v=iTqwa0DCIMA&ab_channel=SeanAllen
    var filteredErrands: [Errand] {
      guard !searchField.isEmpty || selectedTags != "" else { return errands }
      return errands.filter { $0.name.lowercased().contains(searchField.lowercased()) || $0.tags.contains(selectedTags)}
    }
    
    return NavigationStack {
      if (searchField == "") {
        HStack {
          Spacer()
          Button {
            showingSheet.toggle()

          } label: {
            Text("sort by")
              .font(.footnote)
              .padding(.horizontal, 10)
              .foregroundColor(darkBlue)
              .background(Capsule().fill(lightGray))
          }
          Text("|")
          ScrollView(.horizontal, showsIndicators: false) {
            HStack {
              if (selectedTags != "") {
                Button {
                  tagIsClicked = !tagIsClicked
                  selectedTags = ""
                } label: {
                  Text(selectedTags)
                    .font(.footnote)
                    .padding(.horizontal, 10)
                    .foregroundColor(darkBlue)
                    .background(Capsule().fill(mint))
                }
              }
              ForEach(tags.filter { $0 != selectedTags }, id: \.self) { tag in
                Button {
                  tagIsClicked = !tagIsClicked
                  if (tagIsClicked || selectedTags != "") {
                    selectedTags = tag
                  } else {
                    selectedTags = ""
                  }
                } label: {
                  Text(tag)
                    .font(.footnote)
                    .padding(.horizontal, 10)
                    .foregroundColor(darkBlue)
                    .background(Capsule().fill(lightGray))
                }
              }
            }
          }
          Spacer()
        }
      }
      List {
        ForEach(filteredErrands) { errand in
          ErrandView(errand: errand, isCurUser: false, user: user)
            .padding(.bottom, 10)
        }
      }
      .navigationBarTitle("Marketplace", displayMode: .inline)
      .listStyle(.plain)
      .searchable(text: $searchField)
    }
    .accentColor(.black)
//    .sheet(isPresented: $showingSheet) {
//      SortSheet(filteredErrands: filteredErrands, user: user)
//    }
  }
}
