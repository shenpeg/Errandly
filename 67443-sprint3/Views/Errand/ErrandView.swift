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
    let dateFormat = DateFormatter()
    dateFormat.dateFormat = "MM/dd/YY"
    
    return NavigationLink(
      destination: ErrandDetailsView(errand: errand),
      label: {
        VStack(alignment: .leading, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
          HStack {
            Text(errand.name)
              .font(.headline)
            Spacer()
            Text("due by \(dateFormat.string(from: errand.date_due))")
          }
          Spacer()
          HStack {
            Text("\(errand.owner.first_name) \(errand.owner.last_name) |")
//            ForEach(errand.tags) { tag in
//            }
            Text("\(errand.location.latitude), \(errand.location.longitude)")
          }
          Spacer()
          Text("Pay: $\(errand.pay) ")

        }).padding()
      })
  }
}
