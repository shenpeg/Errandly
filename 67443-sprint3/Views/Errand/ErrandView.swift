//
//  ErrandView.swift
//  67443-sprint3
//
//  Created by Julia Graham on 10/24/23.
//

import SwiftUI

struct ErrandView: View {
  let errand: Errand
  let isCurUser: Bool
  
  var body: some View {
    let dateFormat = DateFormatter()
    dateFormat.dateFormat = "MM/dd/YY"
    
    return ZStack {
      NavigationLink(destination:
        ErrandDetailsView(errand: errand)
      ) {
        EmptyView()
      }
      .opacity(0.0)
      
      VStack(alignment: .leading, spacing: 0, content: {
        HStack {
          Text(errand.name)
            .font(.title2)
          
          if (isCurUser) {
            // still need to get edit errand working
            Image(systemName: "pencil")
              .foregroundColor(.black)
              .font(.system(size: 20))
          }
          Spacer()
          
          VStack(alignment: .trailing) {
            Text("due by")
            Text("\(dateFormat.string(from: errand.date_due))")
          }
          .padding(.top, 5)
          .font(.footnote)
          
        }
        .padding(.bottom, 3)
        
        HStack {
          if (isCurUser) {
            Text("your post |")
          }
          else {
            Text("\(errand.owner.first_name) \(errand.owner.last_name.first!). |" as String)
          }
          Text("\(errand.location.latitude), \(errand.location.longitude)")
        }
        .font(.footnote)
        .padding(.bottom, 5)
        
        HStack() {
          ForEach(errand.tags, id: \.self) {tag in
            Text(tag)
              .font(.footnote)
              .padding(.horizontal, 10)
              .foregroundColor(darkBlue)
              .background(Capsule().fill(lightGray))
          }
        }
        .padding(.bottom, 3)
        
        Spacer()
        Divider()
          .overlay(darkBlue)
          .opacity(1)
        
        HStack() {
          Text("$\(String(format: "%.2f", errand.pay)) ")
          Spacer()
          Text("view details")
            .font(.headline)
            .padding(.horizontal, 10)
            .padding(.vertical, 3)
            .foregroundColor(.white)
            .background(Capsule().fill(darkBlue))
        }
        .padding(.top, 10)
        
      })
      .padding(.vertical, 10)
      .padding(.horizontal, 20)
      
    }
    .listRowBackground(
      RoundedRectangle(cornerRadius: 10)
        .background(.clear)
        .foregroundStyle(.white)
        .padding(.horizontal, 10)
    )
    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    .overlay(RoundedRectangle(cornerRadius: 20, style: .continuous).stroke(darkBlue, lineWidth: 1))
    .listRowSeparator(.hidden)
  }
}
