//
//  User.swift
//  67443-sprint3
//
//  Created by Julia Graham on 10/24/23.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Identifiable, Codable {
  
  @DocumentID var id: String?
  var uid: String
  var bio: String
  var can_help_with: [String]
  var first_name: String
  var last_name: String
  var pfp: String
  var phone_number: Int
  var picked_up_errands: [PickedUpErrand]
  var posted_errands: [PostedErrand]
  var school_year: String
  
  
  // To conform to Codable protocol
  enum CodingKeys: String, CodingKey {
    case id
    case uid
    case bio
    case can_help_with
    case first_name
    case last_name
    case pfp
    case phone_number
    case picked_up_errands
    case posted_errands
    case school_year
  }
  
  func getPickedUpErrandsByStatus(_ statuses: [String]) -> [PickedUpErrand] {
    return picked_up_errands.filter{statuses.contains($0.status)}
  }
  
  func getPostedErrandsByStatus(_ statuses: [String]) -> [PostedErrand] {
    return posted_errands.filter{statuses.contains($0.status)}
  }
}
