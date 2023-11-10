//
//  Tag.swift
//  67443-sprint3
//
//  Created by cd on 11/9/23.
//

import Foundation

struct Tag: Identifiable, Hashable {
  var id = UUID()
  var tid: Int
  var label: String
  var isSelected: Bool = false
}
