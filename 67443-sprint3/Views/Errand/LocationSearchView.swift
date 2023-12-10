// tutorial: https://levelup.gitconnected.com/implementing-address-autocomplete-using-swiftui-and-mapkit-c094d08cda24
 //
 import SwiftUI
 import MapKit

struct LocationSearchView: View {
  @EnvironmentObject var locationViewModel: LocationViewModel
  @FocusState private var isFocusedTextField: Bool
  
  var body: some View {
    TextField("", text: $locationViewModel.searchableText)
      .padding(5)
      .background(RoundedRectangle(cornerRadius: 8).stroke(darkBlue, lineWidth: 1))
      .autocorrectionDisabled()
      .focused($isFocusedTextField)
      .onReceive(
        locationViewModel.$searchableText.debounce(
          for: .seconds(1),
          scheduler: DispatchQueue.main
        )
      ) {
        locationViewModel.searchAddress($0)
      }
      .onAppear {
        isFocusedTextField = true
      }
    
    List(self.locationViewModel.results) { address in
      Button {
        print("clickedddddd")
        locationViewModel.searchableText = address.title
      } label: {
        VStack(alignment: .leading) {
          Text(address.title)
          Text(address.subtitle)
            .font(.caption)
        }
      }
    }
    .listStyle(.plain)
    .scrollContentBackground(.hidden)
    .frame(height: 150)
  }
  
}
