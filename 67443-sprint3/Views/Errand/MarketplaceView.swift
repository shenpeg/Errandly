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
  var tags: [String] = ["car", "pet", "laundry"]
  
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
        HStack {
          Circle()
            .fill(Color.blue)
            .frame(height:30)
            .padding()
          TextField("search", text: binding)
            .overlay(
              RoundedRectangle(cornerRadius: 14)
                .stroke(Color.black, lineWidth: 2)
                .padding()
            )
          Circle()
            .fill(Color.blue)
            .frame(height:30)
            .padding()
        }
        HStack {
          Text("sort by")
            .font(.callout)
            .padding(.horizontal, 15)
            .foregroundColor(Color.white)
            .background(Capsule().fill(Color.blue))
          ForEach(tags, id: \.self) {tag in
            Text(tag)
              .font(.callout)
              .padding(.horizontal, 15)
              .foregroundColor(Color.white)
              .background(Capsule().fill(Color.blue))
          }
        }
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
