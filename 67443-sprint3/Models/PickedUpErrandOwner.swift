//
//  PickedUpErrandOwner.swift
//  67443-sprint3
//
//  Created by Julia Graham on 10/24/23.
//

import Foundation
import FirebaseFirestoreSwift

struct PickedUpErrandOwner: Identifiable, Codable {
  
  @DocumentID var id: String?
  var first_name: String
  var last_name: String
  
  
  // To conform to Codable protocol
  enum CodingKeys: String, CodingKey {
    case id
    case first_name
    case last_name

  }
}

