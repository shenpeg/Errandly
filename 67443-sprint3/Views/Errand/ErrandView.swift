//
//  ErrandView.swift
//  67443-sprint3
//
//  Created by Julia Graham on 10/24/23.
//

import SwiftUI

struct ErrandView: View {
  let errand: Errand
  
  var body: some View {
    NavigationLink(
      destination: ErrandDetailsView(errand: errand),
      label: {
        HStack(alignment: .bottom, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
          Text(errand.name)
        }).padding()
      })
  }
}

//#Preview {
//  ErrandView(errand: Errand.example)
//}
