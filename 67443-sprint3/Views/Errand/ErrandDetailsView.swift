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
        dateFormat.dateFormat = "MM/dd/YY"
      
        return VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text(errand.status)
                            .font(.headline)
                            .foregroundColor(darkBlue)
                            .italic()
                            .bold()
                    }
                    Text(errand.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                  
                    HStack() {
                      ForEach(errand.tags, id: \.self) {tag in
                        Text(tag)
                          .font(.callout)
                          .padding(.horizontal, 15)
                          .foregroundColor(darkGray)
                          .background(Capsule().fill(mint))
                      }
                    }

                    ErrandDetailsProfileView(errand: errand)
                    
                    // Horizontal separator line
                    Rectangle()
                      .frame(height: 1)
                      .foregroundColor(darkBlue)
                  
                    HStack {
                        Text(errand.description)
                    }
                    
                    // Horizontal separator line
                    Rectangle()
                      .frame(height: 1)
                      .foregroundColor(darkBlue)
                  
                    HStack {
                        Text("Date Due:")
                        Text(dateFormat.string(from: errand.date_due))
                    }
                }
                .padding(20)
                .navigationBarTitle("Errand Details", displayMode: .inline)
            }
          
          ErrandDetailsPickUpView(errand: errand, errandStatusChanged:  {
            // Handle errand.status change in the parent view if needed
          })
        }
    }
}
