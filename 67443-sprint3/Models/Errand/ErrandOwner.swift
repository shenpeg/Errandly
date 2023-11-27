//
//  ErrandOwner.swift
//  67443-sprint3
//
//  Created by Julia Graham on 10/24/23.
//

import Foundation
import FirebaseFirestoreSwift

struct ErrandOwner: Identifiable, Codable, Hashable {
  
  @DocumentID var errandId: String?
  var id: String
  var first_name: String
  var last_name: String
  var pfp: String
  var phone_number: Int
  
  
  // To conform to Codable protocol
  enum CodingKeys: String, CodingKey {
    case id
    case first_name
    case last_name
    case pfp
    case phone_number

  }
}
