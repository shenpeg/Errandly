//
//  ErrandListView.swift
//  67443-sprint3
//
//  Created by Julia Graham on 10/24/23.
//

import SwiftUI

struct MarketplaceView: View {
  @ObservedObject var errandRepository = ErrandRepository()
  @ObservedObject var marketplaceVM = MarketplaceViewModel()
  @State var searchField: String = ""
  var tags: [String] = ["car", "pet", "laundry"]
  
  var body: some View {
    let errands = errandRepository.errands
    return NavigationView {
      VStack() {
        HStack {
          // location icon
//          Circle()
//            .fill(Color.blue)
//            .frame(height:30)
//            .padding()
          // information icon
//          Circle()
//            .fill(Color.blue)
//            .frame(height:30)
//            .padding()
          Text("sort by")
            .font(.footnote)
            .padding(.horizontal, 10)
            .foregroundColor(darkBlue)
            .background(Capsule().fill(lightGray))
          Text("|")
          ForEach(tags, id: \.self) {tag in
            Text(tag)
              .font(.footnote)
              .padding(.horizontal, 10)
              .foregroundColor(darkBlue)
              .background(Capsule().fill(lightGray))
          }
        }
        List {
          ForEach(errands) { errand in
            ErrandView(errand: errand, isCurUser: false)
              .padding(.bottom, 10)
          }
        }.navigationBarTitle("Errands")
          .listStyle(.plain)
          .searchable(text: $marketplaceVM.searchText)
      }
      
    }
  }
}
//
//struct MarketplaceView_Previews: PreviewProvider {
//    static var previews: some View {
//      MarketplaceView()
//    }
//}
