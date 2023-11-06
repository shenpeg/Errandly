//
//  PickedUpErrand.swift
//  67443-sprint3
//
//  Created by Julia Graham on 10/24/23.
//

import Foundation
import FirebaseFirestoreSwift

struct PickedUpErrand: Identifiable, Codable {
  
  @DocumentID var userId: String?
  var id: String
  var date_due: Date
  var date_posted: Date
  var name: String
  var owner: PickedUpErrandOwner
  var pay: Double
  var status: String
  
  
  // To conform to Codable protocol
  enum CodingKeys: String, CodingKey {
    case userId
    case id
    case date_due
    case date_posted
    case name
    case owner
    case pay
    case status
  }
}

