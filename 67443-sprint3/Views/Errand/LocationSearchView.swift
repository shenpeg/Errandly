// tutorial: https://levelup.gitconnected.com/implementing-address-autocomplete-using-swiftui-and-mapkit-c094d08cda24
 //
 import SwiftUI
 import MapKit
import FirebaseFirestore

struct LocationSearchView: View {
  @EnvironmentObject var locationViewModel: LocationViewModel
  @FocusState private var isFocusedTextField: Bool
  @State var geoPoint: GeoPoint
  @State var locationString: String
  
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
    
    if (!locationViewModel.searchableText.isEmpty && !(locationViewModel.searchableText == locationString)) {
      List(locationViewModel.results) { location in
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
      .listStyle(.plain)
      .scrollContentBackground(.hidden)
      .frame(height: 150)
    }
    else {
      EmptyView()
    }
  }
  
}


//await MainActor.run {
//  if (response.mapItems.first != nil) {
//    return GeoPoint(
//      latitude: response.mapItems.first!.placemark.coordinate.latitude,
//      longitude: response.mapItems.first!.placemark.coordinate.longitude
//    )
//  }
//  else {
//    return nil
//  }
//}

//      await MainActor.run {
//        return GeoPoint(
//          latitude: response.mapItems.first!.placemark.coordinate.latitude,
//          longitude: response.mapItems.first!.placemark.coordinate.longitude
//        )
//        response.mapItems.forEach{mapItem in
//          print("-----------")
//          print(mapItem.placemark.coordinate.longitude)
//          print(mapItem.placemark.coordinate.latitude)
//        }
//        response.mapItems.forEach{mapItem in
//          print("-----------")
//          print(mapItem.placemark.coordinate.longitude)
//          print(mapItem.placemark.coordinate.latitude)
//        }
//        self.annotationItems = response.mapItems.map {
//          AnnotationItem(
//            latitude: $0.placemark.coordinate.latitude,
//            longitude: $0.placemark.coordinate.longitude
//          )
//        }
//      }
//    }
