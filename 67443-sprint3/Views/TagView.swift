//
//  TagView.swift
//  67443-sprint3
//
//  Created by cd on 12/10/23.
//

import Combine
import Foundation
import SwiftUI

struct TagView: View {
  let tag: String
  let viewOnly: Bool
  let isSelected: Bool?

  var body: some View {
    if viewOnly == true {
      // only presenting, not clickable
      Text(tag)
        .font(.system(size: 14))
        .padding(.init(top: 2, leading: 7, bottom: 3, trailing: 7))
        .foregroundColor(black)
        .background(Capsule().fill(lightGray))
    }
    else {
      
      Text(tag)
        .font(.system(size: 14))
        .padding(.init(top: 2, leading: 7, bottom: 3, trailing: 7))
        .foregroundColor(black)
        .background(Capsule().fill(isSelected! ? mint : white))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
              .stroke(Color.black, lineWidth: 1)
        )
    }
  }
}
