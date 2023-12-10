import SwiftUI
import FirebaseFirestore
import CoreLocation
import MapKit

class LocationViewModel:NSObject, ObservableObject, CLLocationManagerDelegate {
  // current location
  @Published var authorizationStatus : CLAuthorizationStatus = .notDetermined
  private let locationManager = CLLocationManager()
  @Published var cordinates : CLLocationCoordinate2D?
  
  // location search
  @Published private(set) var results: Array<Location> = []
  @Published var searchableText = ""
  
  private lazy var localSearchCompleter: MKLocalSearchCompleter = {
    let completer = MKLocalSearchCompleter()
    completer.delegate = self
    return completer
  }()
  
  override init() {
    super.init()
    locationManager.delegate=self
    locationManager.desiredAccuracy=kCLLocationAccuracyBest
    locationManager.startUpdatingLocation()
  }
  
  // current location
  func requestLocationPermission()  {
    locationManager.requestWhenInUseAuthorization()
  }
  
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    authorizationStatus = manager.authorizationStatus
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.last else {return}
    cordinates = location.coordinate
  }
  
  func authorized() -> Bool {
    guard cordinates != nil else { return false }
    return (authorizationStatus == .authorizedWhenInUse || authorizationStatus == .authorizedAlways)
  }
  
  func distanceFromErrand(geoPoint: GeoPoint) -> String {
    guard let cordinates = cordinates else { return "" }
    if !self.authorized() { return "" }
    let userCoord = CLLocation(latitude: cordinates.latitude, longitude: cordinates.longitude)
    let errandCoord = CLLocation(latitude: geoPoint.latitude, longitude: geoPoint.longitude)
    // note: "This method [.distance()] measures the distance between the location in the current object and the value in the location parameter. The distance is calculated by tracing a line between the two points that follows the curvature of the Earth, and measuring the length of the resulting arc. The arc is a smooth curve that doesn’t take into account altitude changes between the two locations."
    let distance = userCoord.distance(from: errandCoord) * 0.000621371 // convert meters to miles
    return "\(String(format: "%.1f", distance)) mi. away"
  }
  
  // location search
  func searchAddress(_ searchableText: String) {
    guard searchableText.isEmpty == false else { return }
    localSearchCompleter.queryFragment = searchableText
  }
  
  func getCoords(location: Location, completion: @escaping (_ geoPoint: GeoPoint?)-> Void) {
    let addressString = location.subtitle.contains(location.title)
      ? location.subtitle : location.title + ", " + location.subtitle
    let geocoder = CLGeocoder()
    
    geocoder.geocodeAddressString(addressString) { (placemarks, error) in
      guard let placemarks = placemarks, let foundCoord = placemarks.first?.location?.coordinate else {
        completion(nil)
        return
      }
      completion(GeoPoint(latitude: foundCoord.latitude, longitude: foundCoord.longitude))
    }
  }
  
  func getAddress(geoPoint: GeoPoint, completion: @escaping (_ address: String?)-> Void) {
    let geocoder = CLGeocoder()
    
    geocoder.reverseGeocodeLocation(CLLocation.init(latitude: geoPoint.latitude, longitude: geoPoint.longitude)) { (places, error) in
      guard let places = places, let foundAddress = places.first else {
        completion(nil)
        return
      }
      completion(foundAddress.name)
    }
  }
  
}

// location search
extension LocationViewModel: MKLocalSearchCompleterDelegate {
  func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
    Task { @MainActor in
      results = completer.results.map {
        Location(title: $0.title, subtitle: $0.subtitle)
      }
    }
  }
  
  func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
    print(error)
  }
}
