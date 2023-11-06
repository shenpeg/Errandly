//
//  PostedErrandRunner.swift
//  67443-sprint3
//
//  Created by Julia Graham on 10/24/23.
//

import Foundation
import FirebaseFirestoreSwift

struct PostedErrandRunner: Identifiable, Codable {
  
  @DocumentID var userId: String?
  var id: String
  var first_name: String
  var last_name: String
  
  
  // To conform to Codable protocol
  enum CodingKeys: String, CodingKey {
    case userId
    case id
    case first_name
    case last_name

  }
}
