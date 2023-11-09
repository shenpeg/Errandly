//
//  ErrandRunner.swift
//  67443-sprint3
//
//  Created by /peggy on 11/9/23.
//

import Foundation
import FirebaseFirestoreSwift

struct ErrandRunner: Identifiable, Codable {
  
  @DocumentID var errandId: String?
  var id: String
  var first_name: String
  var last_name: String
  
  
  // To conform to Codable protocol
  enum CodingKeys: String, CodingKey {
    case errandId
    case id
    case first_name
    case last_name

  }
}
