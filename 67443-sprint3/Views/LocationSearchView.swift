//
//  LocationSearchView.swift
//  67443-sprint3
//
//  Created by Julia Graham on 10/22/23.
//
// tutorial: https://levelup.gitconnected.com/implementing-address-autocomplete-using-swiftui-and-mapkit-c094d08cda24
//

import SwiftUI
import MapKit

struct LocationSearchView: View {
  @StateObject private var locationPermission:LocationViewModel=LocationViewModel()
  
  @StateObject var locationSearchService: LocationSearchService
  
  @FocusState private var isFocusedTextField: Bool
  
  var body: some View {
    NavigationView {
      VStack(alignment: .leading, spacing: 0) {
        
        TextField("Type address", text: $locationSearchService.searchableText)
          .padding()
          .autocorrectionDisabled()
          .focused($isFocusedTextField)
          .font(.title)
          .onReceive(
            locationSearchService.$searchableText.debounce(
              for: .seconds(1),
              scheduler: DispatchQueue.main
            )
          ) {
            locationSearchService.searchAddress($0)
          }
          .background(Color.init(uiColor: .systemBackground))
          .overlay {
            ClearButton(text: $locationSearchService.searchableText)
              .padding(.trailing)
              .padding(.top, 8)
          }
          .onAppear {
            isFocusedTextField = true
          }
        
        List(self.locationSearchService.results) { address in
          VStack(alignment: .leading) {
            Text(address.title)
            Text(address.subtitle)
                .font(.caption)
          }
          .listRowBackground(backgroundColor)
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
      }
      .background(backgroundColor)
      .edgesIgnoringSafeArea(.bottom)
    }
  }
  
  var backgroundColor: Color = Color.init(uiColor: .systemGray6)
}
