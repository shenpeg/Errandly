import SwiftUI
import FirebaseFirestore
import CoreLocation

class LocationViewModel:NSObject, ObservableObject, CLLocationManagerDelegate {
  @Published var authorizationStatus : CLAuthorizationStatus = .notDetermined
  private let locationManager = CLLocationManager()
  @Published var cordinates : CLLocationCoordinate2D?

  override init() {
    super.init()
    locationManager.delegate=self
    locationManager.desiredAccuracy=kCLLocationAccuracyBest
    locationManager.startUpdatingLocation()
  }

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

 }