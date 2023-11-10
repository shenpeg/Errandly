//
//  ErrandListView.swift
//  67443-sprint3
//
//  Created by Julia Graham on 10/24/23.
//

import SwiftUI
let tags: [String] = ["tag", "tag1", "tag2", "car", "plant", "groceries", "laundry"]

struct MarketplaceView: View {
  @ObservedObject var errandRepository = ErrandRepository()
  @ObservedObject var marketplaceViewModel = MarketplaceViewModel()
  @State private var searchField = ""
  @State private var selectedTags = "" // : [String] = []
  @State private var tagIsClicked: Bool = false
  
  @State private var showingSheet = false
  var user: User
  
  var body: some View {
    let errandsVM = marketplaceViewModel.errandViewModels
    // code reference: https://www.youtube.com/watch?v=iTqwa0DCIMA&ab_channel=SeanAllen
    var filteredErrands: [ErrandViewModel] {
      guard !searchField.isEmpty || selectedTags != "" else { return errandsVM }
      return errandsVM.filter { $0.errand.name.lowercased().contains(searchField.lowercased()) || $0.errand.tags.contains(selectedTags)}
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
        ForEach(filteredErrands) { errandVM in
          ErrandView(errand: errandVM.errand, isCurUser: false, user: user)
            .padding(.bottom, 10)
        }
      }
      .navigationBarTitle("Marketplace", displayMode: .inline)
      .listStyle(.plain)
      .searchable(text: $searchField)
    }
    .accentColor(.black)
    .sheet(isPresented: $showingSheet) {
      SortSheet(filteredErrands: filteredErrands, user: user)
    }
  }
}
