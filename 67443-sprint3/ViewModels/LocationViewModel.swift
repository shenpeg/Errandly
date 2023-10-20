//
//  LocationViewModel.swift
//  67443-sprint3
//
//  Created by Julia Graham on 10/19/23.
//  tutorial referenced: https://medium.com/@sarimk80/swiftui-permissions-df11a0f4e264
//

import SwiftUI

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
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        
        cordinates = location.coordinate
    }
    
    
}
