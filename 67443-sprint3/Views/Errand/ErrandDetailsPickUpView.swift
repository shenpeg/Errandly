//
//  ErrandDetailsPickUpView.swift
//  67443-sprint3
//
//  Created by /peggy on 11/1/23.
//

import SwiftUI

struct ErrandDetailsPickUpView: View {
    var errand: Errand

  var body: some View {
    let payFormat = String(format: "$%.2f", errand.pay)
    
    VStack {
      // Add a horizontal separator line above the text and button
      Rectangle()
        .frame(height: 1) // Adjust the height as needed
        .foregroundColor(darkBlue) // Color of the separator
      
      HStack {
        Text("Pay:")
        Text(payFormat)
          .font(.headline)
          .foregroundColor(.black)
        
        Spacer()
        
        Button(action: {
          // Your action when the button is tapped
        }) {
          Text("Pick up errand")
            .font(.headline)
            .foregroundColor(.white)
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background(darkBlue)
            .cornerRadius(40)
        }
        .disabled(true) // Disable the button
      }
      .padding()
      .background(Color.white)
    }
  }
}
