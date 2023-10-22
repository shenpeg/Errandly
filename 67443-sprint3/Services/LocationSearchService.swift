//
//  LocationSearchService.swift
//  67443-sprint3
//
//  Created by Julia Graham on 10/22/23.
//

import Foundation
import MapKit

class LocationSearchService: NSObject, ObservableObject {
  @Published private(set) var results: Array<LocationResult> = []
  @Published var searchableText = ""

  private lazy var localSearchCompleter: MKLocalSearchCompleter = {
    let completer = MKLocalSearchCompleter()
    completer.delegate = self
    return completer
  }()
     
  func searchAddress(_ searchableText: String) {
    guard searchableText.isEmpty == false else { return }
    localSearchCompleter.queryFragment = searchableText
  }
}

extension LocationSearchService: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        Task { @MainActor in
            results = completer.results.map {
                LocationResult(title: $0.title, subtitle: $0.subtitle)
            }
        }
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print(error)
    }
}
