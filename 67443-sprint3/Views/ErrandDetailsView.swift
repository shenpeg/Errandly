//
//  ErrandDetailsView.swift
//  67443-sprint3
//
//  Created by Julia Graham on 10/24/23.
//

import SwiftUI

struct ErrandDetailsView: View {
  var errand: Errand

  var body: some View {
    let dateFormat = DateFormatter()
    dateFormat.dateFormat = "YY/MM/dd"
    
    return VStack(alignment: .leading) {
      Text("Name: \(errand.name)")
      Text("Description: \(errand.description)")
      Text("Pay: $\(errand.pay)")
      Text("Location: \(errand.location.latitude), \(errand.location.longitude)")
      Text("Date posted: \(dateFormat.string(from: errand.date_posted))")
      Text("Date due: \(dateFormat.string(from: errand.date_due))")
      Text("Status: \(errand.status)")
      Text("Owner name: \(errand.owner.first_name) \(errand.owner.last_name)")
    }
    .navigationBarTitle(Text("Errand Details"), displayMode: .inline)
    .frame(alignment: .leading)
  }
}

//#Preview {
//    ErrandDetailsView()
//}
