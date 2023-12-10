// tutorial: https://levelup.gitconnected.com/implementing-address-autocomplete-using-swiftui-and-mapkit-c094d08cda24
 //
 import SwiftUI
 import MapKit

struct LocationSearchView: View {
  @EnvironmentObject var locationViewModel: LocationViewModel
  @FocusState private var isFocusedTextField: Bool
  @State var location: String
  
  var body: some View {
    TextField("", text: $locationViewModel.searchableText)
      .padding(5)
      .background(RoundedRectangle(cornerRadius: 8).stroke(darkBlue, lineWidth: 1))
      .autocorrectionDisabled()
      .focused($isFocusedTextField)
      .onReceive(
        locationViewModel.$searchableText.debounce(
          for: .seconds(0.5),
          scheduler: DispatchQueue.main
        )
      ) {
        locationViewModel.searchAddress($0)
      }
      .onAppear {
        isFocusedTextField = true
      }
    
    if (!locationViewModel.searchableText.isEmpty && !(locationViewModel.searchableText == location)) {
      List(locationViewModel.results) { address in
        Button {
          locationViewModel.searchableText = address.title
          location = locationViewModel.searchableText
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
    else {
      EmptyView()
    }
  }
  
}
