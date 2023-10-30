//
//  Errand.swift
//  67443-sprint3
//
//  Created by Julia Graham on 10/24/23.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore

struct Errand: Identifiable, Codable {
  
  @DocumentID var id: String?
  var date_due: Date
  var date_posted: Date
  var description: String
  var location: GeoPoint
  var name: String
  var owner: ErrandOwner
  var pay: Double
  var status: String
  var tags: [String]
  
  
  // To conform to Codable protocol
  enum CodingKeys: String, CodingKey {
    case id
    case date_due
    case date_posted
    case description
    case location
    case name
    case owner
    case pay
    case status
    case tags
  }
}
