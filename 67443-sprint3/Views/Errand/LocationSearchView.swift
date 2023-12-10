// tutorial: https://levelup.gitconnected.com/implementing-address-autocomplete-using-swiftui-and-mapkit-c094d08cda24
 //
 import SwiftUI
 import MapKit
import FirebaseFirestore

struct LocationSearchView: View {
  @EnvironmentObject var locationViewModel: LocationViewModel
  @Binding var geoPoint: GeoPoint
  @Binding var locationString: String
  
  var body: some View {
    TextField(locationViewModel.searchableText, text: $locationViewModel.searchableText)
      .padding(5)
      .background(RoundedRectangle(cornerRadius: 8).stroke(darkBlue, lineWidth: 1))
      .autocorrectionDisabled()
      .onReceive(
        locationViewModel.$searchableText.debounce(
          for: .seconds(0.5),
          scheduler: DispatchQueue.main
        )
      ) {
        locationViewModel.searchAddress($0)
      }
      .onAppear {
        if (!(geoPoint.latitude == 0 && geoPoint.longitude == 0)) {
          locationViewModel.getAddress(geoPoint: geoPoint) { foundAddress in
            if (foundAddress != nil) {
              locationString = foundAddress!
              locationViewModel.searchableText = locationString
            }
          }
        }
        else {
          locationString = ""
          locationViewModel.searchableText = locationString
        }
      }
    
    if (!locationViewModel.searchableText.isEmpty && !(locationViewModel.searchableText == locationString)) {
      List(locationViewModel.results) { location in
        if (location.subtitle != "Search Nearby") {
          Button {
            locationViewModel.searchableText = location.title
            locationString = locationViewModel.searchableText
            locationViewModel.getCoords(location: location) { foundGeoPoint in
              if (foundGeoPoint != nil) {
                geoPoint = foundGeoPoint!
              }
            }
            
          } label: {
            VStack(alignment: .leading) {
              Text(location.title)
              Text(location.subtitle)
                .font(.caption)
            }
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
